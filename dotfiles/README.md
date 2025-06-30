# Linux dotfiles and toolkit

Deploys dotfiles from my private repo.

Dotfiles - [`https://github.com/hayeseoin/dotfiles`](https://github.com/hayeseoin/dotfiles)


## Requirements

Packages: git, stow

Access to source repos. SSH by default, HTTP with PAT if needed.

## Deploy command

```sh
# SSH
curl -s https://hayeseoin.github.io/bootstrapper-wip/dotfiles/main.sh| bash

# HTTP
export GITHUB_PAT="pat_for_repo"
curl -s https://hayeseoin.github.io/bootstrapper-wip/dotfiles/main.sh| bash -s http $GITHUB_PAT
```