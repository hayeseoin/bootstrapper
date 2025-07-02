# Utilities and scripts

Deploys linux scripts and tools from the repo below

Toolkit - [`https://github.com/hayeseoin/utils-and-scripts`](https://github.com/hayeseoin/utils-and-scripts)

## Requirements

Packages: git

Configure shell to read aliases from `~/.profile.d`
> Important: ALiases are stored as seperate files in `~/.profile.d`, so it's importantt that the shell checks this directory. This can be done by adding the following to `~/.bashrc`
> ```sh
> if [ -d "$HOME/.profile.d" ]; then
>  for file in "$HOME/.profile.d"/*.sh; do
>    [ -r "$file" ] && [ -f "$file" ] && . "$file"
>  done
> fi
> ```

## Deploy command

```sh
# SSH
curl -s https://hayeseoin.github.io/bootstrapper-wip/utils-and-scripts/main.sh | bash

# HTTP
curl -s https://hayeseoin.github.io/bootstrapper-wip/utils-and-scripts/main.sh | bash -s http
```



