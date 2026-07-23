# Holistics project initialization

`holistics-init` creates a local Git repository and downloads its Holistics AMQL code.

## Requirements

- [Holistics CLI](https://docs.holistics.io/docs/cli)
- Git
- GNU Stow

## Installation

Install the `local` dotfiles module to expose the command on `PATH`:

```bash
./install.sh local
```

## Usage

```bash
holistics-init <domain> <directory-amql> <remote-url> <branch>
```

Arguments:

- `domain`: Holistics domain used by `holistics auth`, such as `eu`.
- `directory-amql`: New local directory. Its name must end with `-amql`.
- `remote-url`: Git remote URL to configure as `origin`.
- `branch`: Branch matching the active branch in Holistics.

Example:

```bash
holistics-init \
  eu \
  prusa-amql \
  https://gitlab.com/prusa3d-platform/ai-playground/holistics-bi \
  feature/migration-audit-parity-prep
```

## What it does

The command:

1. Authenticates with the selected Holistics domain.
2. Creates the requested directory. It must not already exist.
3. Initializes a Git repository with `master` as its initial branch.
4. Adds the remote URL as `origin`.
5. Creates and checks out the requested branch.
6. Creates an empty commit.
7. Runs `holistics sync-code .` to download the AMQL code.
