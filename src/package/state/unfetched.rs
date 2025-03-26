use serde::{Deserialize, Serialize};

use crate::package::Binaries;

use super::State;

#[derive(Default, Debug, Serialize, Deserialize, Clone)]
/// Data held by an unfetched package
pub struct Unfetched {
    /// Binaries to create symlinks for
    pub binaries: Binaries,
}

impl State for Unfetched {}
