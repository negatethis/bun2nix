# This file was autogenerated by `bun2nix`, editing it is not recommended.
# Consume it with `callPackage` in your actual derivation -> https://nixos-and-flakes.thiscute.world/nixpkgs/callpackage
{
  fetchurl,
  gnutar,
  coreutils,
  runCommand,
  symlinkJoin,
}: let
  # Bun packages to install
  packages = [
    {
      name = "@types/bun";
      path = fetchurl {
        name = "@types/bun@1.2.4";
        url  = "https://registry.npmjs.org/@types/bun/-/bun-1.2.4.tgz";
        hash = "sha256-O01ctlMKEB5nmokJir6UwrPEPWaW9zhiqS0YkwPVX9Y=";
      };
    }
    {
      name = "@types/ws";
      path = fetchurl {
        name = "@types/ws@8.5.14";
        url  = "https://registry.npmjs.org/@types/ws/-/ws-8.5.14.tgz";
        hash = "sha256-SsUn5egoHI/5PcxHQwwtNupaBcwgePqjR3uTG7Ew37w=";
      };
    }
    {
      name = "undici-types";
      path = fetchurl {
        name = "undici-types@6.20.0";
        url  = "https://registry.npmjs.org/undici-types/-/undici-types-6.20.0.tgz";
        hash = "sha256-coyp/P9nY3Lk3NZIteJvu9sonsK89nXnYBzCE0pejW4=";
      };
    }
    {
      name = "typescript";
      path = fetchurl {
        name = "typescript@5.7.3";
        url  = "https://registry.npmjs.org/typescript/-/typescript-5.7.3.tgz";
        hash = "sha256-gM/KElS6uOgdY5F45C1kBthW+6bjTK1g0atQ7m5ffrs=";
      };
    }
    {
      name = "@types/node";
      path = fetchurl {
        name = "@types/node@22.13.5";
        url  = "https://registry.npmjs.org/@types/node/-/node-22.13.5.tgz";
        hash = "sha256-jtFd0kKkgHHRYLsT8YUk7PgWSyu0nVwrUHm+IMzNRKQ=";
      };
    }
    {
      name = "bun-types";
      path = fetchurl {
        name = "bun-types@1.2.4";
        url  = "https://registry.npmjs.org/bun-types/-/bun-types-1.2.4.tgz";
        hash = "sha256-lXqzNu+EFE1bzON4rLGrSdws76vuyStC1Ehxa3n/6/0=";
      };
    }
  ];

  # Extract a package from a tar file
  extractPackage = pkg:
    runCommand "bun2nix-extract-${pkg.name}" {buildInputs = [gnutar coreutils];} ''
      mkdir -p $out/${pkg.name}
      tar -xzf ${pkg.path} -C $out/${pkg.name} --strip-components=1
    '';

  # Build the node modules directory
  nodeModules = symlinkJoin {
    name = "node-modules";
    paths = map extractPackage packages;
  };
in {
  inherit nodeModules packages;
}