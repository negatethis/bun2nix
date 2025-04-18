# Bun2Nix

A fast rust based tool for converting [Bun](https://bun.sh/) (v1.2+) package lock files to [Nix](https://nixos.wiki/) expressions, and consuming them in a reproducible derivation to produce packages.

## Installation

### As a Flake

Add a flake input as follows:

```nix
inputs.bun2nix.url = "github:baileyluTCD/bun2nix";
```

Select the appropriate package for your system ([flake-utils](https://github.com/numtide/flake-utils) recommended):

```nix
bun2nix = inputs.bun2nix.defaultPackage.${system};
```

Add the binary to your environment:

```nix
devShells.default = pkgs.mkShell {
  packages = with pkgs; [
    bun
    bun2nix.bin
  ];
};
```

## Usage

`bun2nix` can be invoked as a command as follows:

```
Convert Bun (v1.2+) packages to Nix expressions

Usage: bun2nix [OPTIONS] [COMMAND]

Commands:
  cache  Cache related subcommands
  help   Print this message or the help of the given subcommand(s)

Options:
  -l, --lock-file <LOCK_FILE>
          The Bun (v1.2+) lockfile to use to produce the Nix expression

          [default: ./bun.lock]

  -o, --output-file <OUTPUT_FILE>
          The output file to write to - if no file location is provided, print to stdout instead

  -c, --cache-location <CACHE_LOCATION>
          The sqlite database to use as the cache - will be created if it does not exist.

          Default value of <system cache directory>/bun2nix is assigned when no value is passed to `cache_location`.

          [default: /home/luke/.cache/bun2nix]

      --disable-cache
          Disable usage of the cache entirely

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

It is a good idea to add `bun2nix` to your `package.json` file as a `postinstall` script to keep your generated `bun.nix` file up to date:

```json
{
  "name": "examples",
  "scripts": {
    "postinstall": "bun2nix -o bun.nix"
  },
  "module": "index.ts",
  "type": "module",
  "private": true,
  "devDependencies": {
    "@types/bun": "latest"
  },
  "peerDependencies": {
    "typescript": "^5"
  }
}
```

This will produce a ready to use `bun.nix` file representing your `node_modules` directory, which can be consumed with a provided derivation function as follows:

```nix
{bun2nix, ...}:
bun2nix.mkBunDerivation {
  name = "minimal-bun2nix-example";
  version = "1.0.0";

  src = ./.;

  bunNix = ./bun.nix;

  buildFlags = [
    "--compile"
    "--minify"
    "--sourcemap"
    "--bytecode"
  ];

  index = ./index.ts;
}
```

## Examples

Check out our `examples/` directory for ready to use examples for compiling a bun binary and a React website through `bun2nix`.
