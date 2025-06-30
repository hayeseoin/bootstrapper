#!/bin/bash

GIT_ENDPOINT="git@github.com:hayeseoin"
GIT_ACCESS="ssh"

if [[ "$1" == 'http' ]]; then
    GIT_ENDPOINT="https://github.com/hayeseoin"
    GIT_ACCESS="http"
fi

GIT_REPO="utils-and-scripts"
DIRECTORY_TARGET_NAME=".utils-and-scripts"
GIT_REPO_URL="$GIT_ENDPOINT/$GIT_REPO.git"
GIT_REPO_TARGET="$HOME/$DIRECTORY_TARGET_NAME"
SETUP_SCRIPT="$GIT_REPO_TARGET/linux/setup/main.sh"

# Check git and stow are installed
GIT_INSTALLED=1
echo "Checking if git and stow are available..."
which git
if [[ $? -eq 1 ]]; then
    echo "Git is not installed"
    GIT_OR_STOW_INSTALLED=0
fi

if [[ $GIT_INSTALLED -eq 0 ]]; then
    exit 1
fi

# Supress git ssh check
if "$GIT_ACCESS" == ssh; then
    if [ ! -f "$HOME/.ssh/known_hosts" ]; then
        touch "$HOME/.ssh/known_hosts"
    fi
    cp $HOME/.ssh/known_hosts $HOME/.ssh/known_hosts_bootstrap_backup
    ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null
fi

echo "Checking git connection..."
git ls-remote $GIT_REPO_URL > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "Unable to connect to repo or git."
    exit 1
fi
echo "Connected to git."

echo 'Checking $GIT_REPO_TARGET directory exists'
if [[ ! -d $GIT_REPO_TARGET ]]; then
    echo "$GIT_REPO_TARGET directory doesn't exist, creating it."
    git clone $GIT_REPO_URL $GIT_REPO_TARGET
    if [[ $? -ne 0 ]]; then
        echo "Failed to clone repository"
        exit 1
    fi
fi
echo 'utils and scripts directory exists.'

if [[ ! -d $GIT_REPO_TARGET/.git ]]; then
    echo '$GIT_REPO_TARGET exists but is not a git repo, exiting...'
    exit 1
fi
echo "$GIT_REPO_TARGET directory is a git repo."

# utils-and-scripts - run internal setup script
echo "Running setup script."
$SETUP_SCRIPT

# Restore known hosts
if "$GIT_ACCESS" == ssh; then
    rm -f $HOME/.ssh/known_hosts
    mv $HOME/.ssh/known_hosts_bootstrap_backup $HOME/.ssh/known_hosts
fi

echo 'Completed.'