# keep-empty

Marks empty directories with `.keep` files to preserve them in version control.
A declarative CLI tool to mark empty directories with `.keep` files.

## ✨ Features

- Pure Bash implementation with modular IO separation
- Declarative packaging via Nix flakes
- Ergonomic CLI with help text and dry-run support
- Reproducible dev shell with linting and tests
- Pure logic separation (`lib/logic.sh`)
- IO orchestration (`lib/io.sh`)
- Ergonomic CLI with dry-run and help
- Declarative packaging via Nix flakes
- Composable `maybe_` functions for safe logic


## Project Structure

```
.
├── main.sh              # Entry point
├── lib/                 # Modular helpers
│   ├── io.sh            # Impure IO functions
│   └── maybe.sh         # Pure logic functions
├── tests/               # bats test suite
├── flake.nix            # Nix flake definition
└── README.md
```

---

## To Quick Start

```bash
nix run github:yourname/keep-empty
```

## To Build Locally

```bash
nix build
```
Result will be in ./result/bin/keep-empty

## To Tests
```bash
nix flake check
```
Includes shellcheck linting and bats tests

## To Install (via Home Manager)

```nix
{
  home.packages = [
    inputs.keep-empty.packages.${system}.default
  ];
}
```

## To Use

```bash
keep-empty /path/to/dir --help
keep-empty /path/to/dir --dry-run
keep-empty /path/to/dir
```
