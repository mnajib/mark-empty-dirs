# mark-empty-dirs

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
├── flake.lock           # Nix flake lock file (pinned dependencies)
├── flake.nix            # Flake definition with build/devShell/apps/checks
├── lib/                 # Modular Bash helpers
│   ├── args.sh          # Argument parsing (impure, CLI-facing)
│   ├── io.sh            # Logging and help text (impure)
│   └── logic.sh         # Pure maybe_ functions for directory analysis
├── LICENSE              # Project license
├── main.sh              # CLI entry point (orchestrates logic and IO)
└── README.md            # Documentation and usage guide

```

---

## To Quick Start

```bash
nix run https://github.com/nyumtide/mark-empty-dirs.git
```

## To Build Locally

```bash
nix build
```
Result will be in ./result/bin/mark-empty-dirs

## To Tests
```bash
nix flake check
```
Includes shellcheck linting and bats tests

## To Install (via Home Manager)

```nix
{
  home.packages = [
    inputs.mark-empty-dirs.packages.${system}.default
  ];
}
```

## To Use

```bash
mark-empty-dirs /path/to/dir --help
mark-empty-dirs /path/to/dir --dry-run
mark-empty-dirs /path/to/dir
```
