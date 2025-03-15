# This file was autogenerated by `bun2nix`, editing it is not recommended.
# Consume it with `callPackage` in your actual derivation -> https://nixos-and-flakes.thiscute.world/nixpkgs/callpackage
{
  lib,
  fetchurl,
  gnutar,
  coreutils,
  runCommand,
  symlinkJoin,
  bun,
}: let
  # Set of Bun packages to install
  packages = {
    "which-module" = fetchurl {
      name = "which-module@2.0.1";
      url = "https://registry.npmjs.org/which-module/-/which-module-2.0.1.tgz";
      hash = "sha256-/47vIvmJKGxKM9bFOs8RAnpMJjTrBCxj1783ALNCSXM=";
    };
    "wrap-ansi" = fetchurl {
      name = "wrap-ansi@6.2.0";
      url = "https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-6.2.0.tgz";
      hash = "sha256-1G/EEvBNhzcApVe8lobULA1seXnhglzv6/QnnKnWePg=";
    };
    "path-exists" = fetchurl {
      name = "path-exists@4.0.0";
      url = "https://registry.npmjs.org/path-exists/-/path-exists-4.0.0.tgz";
      hash = "sha256-27U1yTAs6bP3d+zj/wVcyNiIkKHh3t3ARTQK73b7d1w=";
    };
    "set-blocking" = fetchurl {
      name = "set-blocking@2.0.0";
      url = "https://registry.npmjs.org/set-blocking/-/set-blocking-2.0.0.tgz";
      hash = "sha256-2TSu59ueCdoJ6HckdDMV/+iIEwqm4E+73srJhfauaT0=";
    };
    "p-locate" = fetchurl {
      name = "p-locate@4.1.0";
      url = "https://registry.npmjs.org/p-locate/-/p-locate-4.1.0.tgz";
      hash = "sha256-2Vpq5GLj2WfesMJQvaHDu+v+hqWIMtJ7IEx7dKdvpfA=";
    };
    "cowsay" = fetchurl {
      name = "cowsay@1.6.0";
      url = "https://registry.npmjs.org/cowsay/-/cowsay-1.6.0.tgz";
      hash = "sha256-AhDv6s+TRKz4Cy9qQDdRiichfaUoJfhOPeBLOFMi04k=";
    };
    "yargs-parser" = fetchurl {
      name = "yargs-parser@18.1.3";
      url = "https://registry.npmjs.org/yargs-parser/-/yargs-parser-18.1.3.tgz";
      hash = "sha256-DJE17iMw/ZzcGf7RG42aeykvXdjd9AwTsFE0BpPrvlg=";
    };
    "cliui/strip-ansi/ansi-regex" = fetchurl {
      name = "ansi-regex@5.0.1";
      url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-5.0.1.tgz";
      hash = "sha256-Dg6tzaragF212FtTrVzcoHYLmW7hmeyWWOezSqbI4Nk=";
    };
    "wrap-ansi/strip-ansi/ansi-regex" = fetchurl {
      name = "ansi-regex@5.0.1";
      url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-5.0.1.tgz";
      hash = "sha256-Dg6tzaragF212FtTrVzcoHYLmW7hmeyWWOezSqbI4Nk=";
    };
    "yargs/string-width/strip-ansi/ansi-regex" = fetchurl {
      name = "ansi-regex@5.0.1";
      url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-5.0.1.tgz";
      hash = "sha256-Dg6tzaragF212FtTrVzcoHYLmW7hmeyWWOezSqbI4Nk=";
    };
    "string-width" = fetchurl {
      name = "string-width@2.1.1";
      url = "https://registry.npmjs.org/string-width/-/string-width-2.1.1.tgz";
      hash = "sha256-InzcDOkgkAugjJxTvfvTarIteNllfbthCOT5ua5ZeSw=";
    };
    "ansi-styles" = fetchurl {
      name = "ansi-styles@4.3.0";
      url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-4.3.0.tgz";
      hash = "sha256-LFOaRthatgMxg5l0NNLZpcos7vwStNuQIvVkeEzXmH8=";
    };
    "find-up" = fetchurl {
      name = "find-up@4.1.0";
      url = "https://registry.npmjs.org/find-up/-/find-up-4.1.0.tgz";
      hash = "sha256-M6mwU1MG0uBeCicIi2g0S1Ksdn1XbvYLerFzqg1aJus=";
    };
    "@types/bun" = fetchurl {
      name = "@types/bun@1.2.4";
      url = "https://registry.npmjs.org/@types/bun/-/bun-1.2.4.tgz";
      hash = "sha256-O01ctlMKEB5nmokJir6UwrPEPWaW9zhiqS0YkwPVX9Y=";
    };
    "p-limit" = fetchurl {
      name = "p-limit@2.3.0";
      url = "https://registry.npmjs.org/p-limit/-/p-limit-2.3.0.tgz";
      hash = "sha256-OEtFJAnP61xvqC3Gjr+kmLJHF7dPuNP+brK7iZCNspU=";
    };
    "yargs" = fetchurl {
      name = "yargs@15.4.1";
      url = "https://registry.npmjs.org/yargs/-/yargs-15.4.1.tgz";
      hash = "sha256-Qav+xqdM+0+jMK8qM7hn36BqmytDm7ASRMT0fFhd5TU=";
    };
    "@types/ws" = fetchurl {
      name = "@types/ws@8.5.14";
      url = "https://registry.npmjs.org/@types/ws/-/ws-8.5.14.tgz";
      hash = "sha256-SsUn5egoHI/5PcxHQwwtNupaBcwgePqjR3uTG7Ew37w=";
    };
    "is-fullwidth-code-point" = fetchurl {
      name = "is-fullwidth-code-point@2.0.0";
      url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz";
      hash = "sha256-TNDQ7e5r8yi2QWYgVNaen6+RJivu5vFY65dCIM6roGs=";
    };
    "cliui" = fetchurl {
      name = "cliui@6.0.0";
      url = "https://registry.npmjs.org/cliui/-/cliui-6.0.0.tgz";
      hash = "sha256-U4v8l1Mzj464FsRuflQbO7raGERs+LUUnPqq//Aay9g=";
    };
    "color-name" = fetchurl {
      name = "color-name@1.1.4";
      url = "https://registry.npmjs.org/color-name/-/color-name-1.1.4.tgz";
      hash = "sha256-UHt8RGHo65QTVa+aWemn4CzQ58YXa0jRgJdmNE8/Fwg=";
    };
    "get-stdin" = fetchurl {
      name = "get-stdin@8.0.0";
      url = "https://registry.npmjs.org/get-stdin/-/get-stdin-8.0.0.tgz";
      hash = "sha256-VQMl1m2rqflYVjd0kxQwp/Vb0qq8R3A/LKMQLtNoRAs=";
    };
    "strip-final-newline" = fetchurl {
      name = "strip-final-newline@2.0.0";
      url = "https://registry.npmjs.org/strip-final-newline/-/strip-final-newline-2.0.0.tgz";
      hash = "sha256-aR/7LICNb2TQJWXw6OHhzSXqzh4ywGXpPWwaok4rAHU=";
    };
    "wrap-ansi/string-width/is-fullwidth-code-point" = fetchurl {
      name = "is-fullwidth-code-point@3.0.0";
      url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz";
      hash = "sha256-b0Fdrl3GBw8bQtruYWXquUGpcQGYIwX6zIuv2vMAvEo=";
    };
    "cliui/string-width/is-fullwidth-code-point" = fetchurl {
      name = "is-fullwidth-code-point@3.0.0";
      url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz";
      hash = "sha256-b0Fdrl3GBw8bQtruYWXquUGpcQGYIwX6zIuv2vMAvEo=";
    };
    "yargs/string-width/is-fullwidth-code-point" = fetchurl {
      name = "is-fullwidth-code-point@3.0.0";
      url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-3.0.0.tgz";
      hash = "sha256-b0Fdrl3GBw8bQtruYWXquUGpcQGYIwX6zIuv2vMAvEo=";
    };
    "require-directory" = fetchurl {
      name = "require-directory@2.1.1";
      url = "https://registry.npmjs.org/require-directory/-/require-directory-2.1.1.tgz";
      hash = "sha256-cDvuCEQ2A4P+SoeS1KWlYmR0JqBT51l6HScqxVTzhsg=";
    };
    "undici-types" = fetchurl {
      name = "undici-types@6.20.0";
      url = "https://registry.npmjs.org/undici-types/-/undici-types-6.20.0.tgz";
      hash = "sha256-coyp/P9nY3Lk3NZIteJvu9sonsK89nXnYBzCE0pejW4=";
    };
    "get-caller-file" = fetchurl {
      name = "get-caller-file@2.0.5";
      url = "https://registry.npmjs.org/get-caller-file/-/get-caller-file-2.0.5.tgz";
      hash = "sha256-exPhyBlJ/0wbquSsTjSZBJLV6Khtq347kAJ7H1Emk18=";
    };
    "typescript" = fetchurl {
      name = "typescript@5.7.3";
      url = "https://registry.npmjs.org/typescript/-/typescript-5.7.3.tgz";
      hash = "sha256-gM/KElS6uOgdY5F45C1kBthW+6bjTK1g0atQ7m5ffrs=";
    };
    "@types/node" = fetchurl {
      name = "@types/node@22.13.5";
      url = "https://registry.npmjs.org/@types/node/-/node-22.13.5.tgz";
      hash = "sha256-jtFd0kKkgHHRYLsT8YUk7PgWSyu0nVwrUHm+IMzNRKQ=";
    };
    "color-convert" = fetchurl {
      name = "color-convert@2.0.1";
      url = "https://registry.npmjs.org/color-convert/-/color-convert-2.0.1.tgz";
      hash = "sha256-kg+kNTjAGaCF278Ey29yzDN2JOX1IXUZ8Oey73hOfOE=";
    };
    "bun-types" = fetchurl {
      name = "bun-types@1.2.4";
      url = "https://registry.npmjs.org/bun-types/-/bun-types-1.2.4.tgz";
      hash = "sha256-lXqzNu+EFE1bzON4rLGrSdws76vuyStC1Ehxa3n/6/0=";
    };
    "yargs/string-width/strip-ansi" = fetchurl {
      name = "strip-ansi@6.0.1";
      url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.1.tgz";
      hash = "sha256-m9t10L/0nxVt2MO8sOBrP6lsPYjd1MNCpDRYZqQMCMo=";
    };
    "wrap-ansi/strip-ansi" = fetchurl {
      name = "strip-ansi@6.0.1";
      url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.1.tgz";
      hash = "sha256-m9t10L/0nxVt2MO8sOBrP6lsPYjd1MNCpDRYZqQMCMo=";
    };
    "cliui/strip-ansi" = fetchurl {
      name = "strip-ansi@6.0.1";
      url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.1.tgz";
      hash = "sha256-m9t10L/0nxVt2MO8sOBrP6lsPYjd1MNCpDRYZqQMCMo=";
    };
    "ansi-regex" = fetchurl {
      name = "ansi-regex@3.0.1";
      url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-3.0.1.tgz";
      hash = "sha256-mJwKSCr4eX6JDYmb3AxUw0OQClMDYXYEocOamMCnZFc=";
    };
    "p-try" = fetchurl {
      name = "p-try@2.2.0";
      url = "https://registry.npmjs.org/p-try/-/p-try-2.2.0.tgz";
      hash = "sha256-o5CyuJiZ35UK/AME6rp80fXjdGsuNwdYqbUPF35xN5A=";
    };
    "strip-ansi" = fetchurl {
      name = "strip-ansi@4.0.0";
      url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-4.0.0.tgz";
      hash = "sha256-qrCoRzaZ4BaSusK7g9VGDilaPa0OZlPg3Wr1fo/2IC0=";
    };
    "wrap-ansi/string-width" = fetchurl {
      name = "string-width@4.2.3";
      url = "https://registry.npmjs.org/string-width/-/string-width-4.2.3.tgz";
      hash = "sha256-rbtPsbJugGmvma3/AHk2nJPxfPiHuRCGaR1nHdvVKTQ=";
    };
    "yargs/string-width" = fetchurl {
      name = "string-width@4.2.3";
      url = "https://registry.npmjs.org/string-width/-/string-width-4.2.3.tgz";
      hash = "sha256-rbtPsbJugGmvma3/AHk2nJPxfPiHuRCGaR1nHdvVKTQ=";
    };
    "cliui/string-width" = fetchurl {
      name = "string-width@4.2.3";
      url = "https://registry.npmjs.org/string-width/-/string-width-4.2.3.tgz";
      hash = "sha256-rbtPsbJugGmvma3/AHk2nJPxfPiHuRCGaR1nHdvVKTQ=";
    };
    "locate-path" = fetchurl {
      name = "locate-path@5.0.0";
      url = "https://registry.npmjs.org/locate-path/-/locate-path-5.0.0.tgz";
      hash = "sha256-rj0bk2CkNYQKgajH2in1ljDdeTw/OaCPFfc/04lAU7c=";
    };
    "decamelize" = fetchurl {
      name = "decamelize@1.2.0";
      url = "https://registry.npmjs.org/decamelize/-/decamelize-1.2.0.tgz";
      hash = "sha256-tK3v9RDjjDoCcDvLpy/748ZbWR8Tx4xqRZtegBo+KGQ=";
    };
    "emoji-regex" = fetchurl {
      name = "emoji-regex@8.0.0";
      url = "https://registry.npmjs.org/emoji-regex/-/emoji-regex-8.0.0.tgz";
      hash = "sha256-tczZ+/sICY7vvra2tLQNtts6z5JD4yfgOZJaqGYcsQc=";
    };
    "y18n" = fetchurl {
      name = "y18n@4.0.3";
      url = "https://registry.npmjs.org/y18n/-/y18n-4.0.3.tgz";
      hash = "sha256-vElwRJgBQpunciiibwPgW6fppemBEe20TWoPx7ZmDs8=";
    };
    "require-main-filename" = fetchurl {
      name = "require-main-filename@2.0.0";
      url = "https://registry.npmjs.org/require-main-filename/-/require-main-filename-2.0.0.tgz";
      hash = "sha256-xbtWYxj7YJHHwqx8Crpu63szL/z6+tImii3BKk1CjgA=";
    };
    "camelcase" = fetchurl {
      name = "camelcase@5.3.1";
      url = "https://registry.npmjs.org/camelcase/-/camelcase-5.3.1.tgz";
      hash = "sha256-xgkySriJUV8vc1TdzDGbYIDJt28qwUQcA9oDHIVFhpY=";
    };
  };

  # List of binary symlinks to create in the `node_modules/.bin` folder
  binaries = {
    "cowsay" = "../cowsay/cli.js";
    "cowthink" = "../cowsay/cli.js";
    "tsc" = "../typescript/bin/tsc";
    "tsserver" = "../typescript/bin/tsserver";
  };

  # Extract a package from a tar file
  extractPackage = name: pkg:
    runCommand "bun2nix-extract-${name}" {buildInputs = [gnutar coreutils];} ''
      # Extract the files from npm
      mkdir -p $out/${name}
      tar -xzf ${pkg} -C $out/${name} --strip-components=1

      # Patch binary shebangs to point to bun
      mkdir -p $out/bin
      ln -s ${bun}/bin/bun $out/bin/node
      PATH=$out/bin:$PATH patchShebangs $out/${name}
      patchShebangs $out/${name}
    '';

  # Link a binary from a package
  linkBin = name: dest:
    runCommand "bun2nix-binary-${name}" {} ''
      mkdir -p $out

      ln -sn ${dest} $out/${name}
    '';

  # Construct the .bin directory
  dotBinDir = symlinkJoin {
    name = ".bin";
    paths = lib.mapAttrsToList linkBin binaries;
  };

  # Link the packages to inject into node_modules
  packageFiles = symlinkJoin {
    name = "package-files";
    paths = lib.mapAttrsToList extractPackage packages;
  };

  # Build the node modules directory
  nodeModules = runCommand "node-modules" {} ''
    mkdir -p $out

    # Packages need to be regular folders
    cp -rL ${packageFiles}/* $out/

    # Executables need to be symlinks
    cp -r ${dotBinDir} $out/.bin
  '';
in {
  inherit nodeModules packages dotBinDir binaries;
}
