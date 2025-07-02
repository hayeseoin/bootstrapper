# Bootstrapping - Meta Repo

Public meta repo for bootstrapping configs. This repo is public, and the scripts hosted in it are public. Not all of the source repos it pulls from are public. 

## [Dotfiles](/dotfiles)

Deploys my preferred dotfiles config. Private repo.

### Deploy command: 
```sh
curl -s https://hayeseoin.github.io/bootstrapper-wip/dotfiles/main.sh| bash
```
Dotfiles - [`https://github.com/hayeseoin/dotfiles`](https://github.com/hayeseoin/dotfiles)

## [Utilities and Scripts](/utils-and-scripts/)

Deploys my linux toolkit to `~/.utils-and-scripts/linux` including aliases. Public

### Deploy:
```sh
# SSH
curl -s https://hayeseoin.github.io/bootstrapper-wip/utils-and-scripts/main.sh | bash

# HTTP
curl -s https://hayeseoin.github.io/bootstrapper-wip/utils-and-scripts/main.sh | bash -s http
```
Toolkit - [`https://github.com/hayeseoin/utils-and-scripts`](https://github.com/hayeseoin/utils-and-scripts)
