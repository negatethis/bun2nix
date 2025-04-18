//! This module holds the core implementation for the package type and related methods

use std::{
    fmt::Debug,
    hash::{Hash, Hasher},
};

use async_process::Command;
use serde::{Deserialize, Serialize};
use state::State;
use store_prefetch::StorePrefetch;

use crate::{
    cache::CacheRow,
    error::{Error, Result},
};

mod binaries;
mod fetch_many;
mod metadata;
mod normalized_binary;
mod state;
mod store_prefetch;

pub use binaries::Binaries;
pub use fetch_many::FetchMany;
pub use metadata::MetaData;
pub use normalized_binary::NormalizedBinary;
pub use state::{Fetched, Normalized, Unfetched};

#[derive(Default, Debug, Serialize, Deserialize, Clone)]
#[serde(rename_all = "camelCase", default)]
/// # Package
///
/// An individual package found in a bun lockfile.
///
/// It holds two states: `Unfetched` and `Fetched` to differentiate between those which we have a
/// hash for and those which we do not.
pub struct Package<D: State> {
    /// The name of the package, as found in the `./node_modules` directory or in an import
    /// statement
    pub name: String,

    /// The package's identifier string for fetching from npm
    pub npm_identifier: String,

    /// The state the package is currently in
    pub data: D,
}

impl Package<Unfetched> {
    /// # Package Constructor
    ///
    /// Produce a new instance of an unfetched package
    pub fn new(name: String, npm_identifier: String, binaries: Binaries) -> Self {
        Self {
            name,
            npm_identifier,
            data: Unfetched { binaries },
        }
    }

    /// # Fetch One
    ///
    /// Prefetch a single package from a url without interacting with the cache and produce a fetched package
    pub async fn fetch_one(self) -> Result<Package<Fetched>> {
        let url = self.to_npm_url()?;

        let output = Command::new("nix")
            .args(["store", "prefetch-file", "--json", &url])
            .output()
            .await?;

        if !output.status.success() {
            return Err(Error::PrefetchStderr(String::from_utf8(output.stderr)?));
        }

        let store_return: StorePrefetch = serde_json::from_slice(&output.stdout)?;

        assert_eq!(
            51,
            store_return.hash.len(),
            "hash was not 51 chars: {}",
            store_return.hash
        );
        assert!(store_return.hash.contains("sha256"));

        Ok(Package {
            name: self.name,
            npm_identifier: self.npm_identifier,
            data: Fetched {
                url,
                hash: store_return.hash,
                binaries: self.data.binaries,
            },
        })
    }

    /// # NPM url converter
    ///
    /// Produce a url needed to fetch from the npm api from a package
    ///
    /// ## Usage
    ///```rust
    /// use bun2nix::Package;
    ///
    /// let package = Package {
    ///     npm_identifier: "@alloc/quick-lru@5.2.0".to_owned(),
    ///     ..Default::default()
    /// };
    ///
    /// assert_eq!(package.to_npm_url().unwrap(), "https://registry.npmjs.org/@alloc/quick-lru/-/quick-lru-5.2.0.tgz")
    /// ```
    pub fn to_npm_url(&self) -> Result<String> {
        let Some((user, name_and_ver)) = self.npm_identifier.split_once("/") else {
            let Some((name, ver)) = self.npm_identifier.split_once("@") else {
                return Err(Error::NoAtInPackageIdentifier);
            };

            return Ok(format!(
                "https://registry.npmjs.org/{}/-/{}-{}.tgz",
                name, name, ver
            ));
        };

        let Some((name, ver)) = name_and_ver.split_once("@") else {
            return Err(Error::NoAtInPackageIdentifier);
        };

        Ok(format!(
            "https://registry.npmjs.org/{}/{}/-/{}-{}.tgz",
            user, name, name, ver
        ))
    }
}

impl Package<Fetched> {
    /// # Try From Name and Cache Row
    ///
    /// Try create a new fetched package from a cache entry by binding a name to make it
    /// suitable for writing
    pub fn try_from_name_and_cache_row(name: String, row: CacheRow) -> Result<Self> {
        Ok(Self {
            name,
            npm_identifier: row.npm_identifier,
            data: Fetched {
                url: row.url,
                hash: row.hash,
                binaries: serde_json::from_str(&row.binaries)?,
            },
        })
    }

    /// # Normalize Packages
    ///
    /// Normalizes a package's data fields to prepare it to be output
    ///
    /// This includes building the output path in `node_modules` and a proper binaries list
    pub fn normalize(self) -> Package<Normalized> {
        Package {
            npm_identifier: self.npm_identifier,
            data: Normalized {
                out_path: Normalized::convert_name_to_out_path(&self.name),
                url: self.data.url,
                hash: self.data.hash,
                binaries: self.data.binaries.normalize(&self.name),
            },
            name: self.name,
        }
    }
}

impl<D: State> Hash for Package<D> {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.name.hash(state);
        self.npm_identifier.hash(state);
    }
}

impl<D: State> PartialEq for Package<D> {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name && self.npm_identifier == other.npm_identifier
    }
}

impl<D: State> PartialOrd for Package<D> {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl<D: State> Eq for Package<D> {}

impl<D: State> Ord for Package<D> {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        (&self.name, &self.npm_identifier).cmp(&(&other.name, &other.npm_identifier))
    }
}
