#!/bin/bash

DOTFILES_REPO="git@github.com:hayeseoin/dotfiles.git"
DOTFILES_REPO_NAME="dotfiles"

UTILS_AND_SCRIPTS_REPO="git@github.com:hayeseoin/utils-and-scripts.git"
UTILS_AND_SCRIPTS_REPO_NAME=".utils-and-scripts"
UTILS_AND_SCRIPTS_MODE="" # system or local

GIT_OR_STOW_INSTALLED=1

# Check git and stow are installed
echo "Checking if git and stow are available..."
which git
if [[ $? -eq 1 ]]; then
    echo "Git is not installed"
    GIT_OR_STOW_INSTALLED=0
fi

which stow
if [[ $? -eq 1 ]]; then
    echo "Stow is not installed"
    GIT_OR_STOW_INSTALLED=0
fi

if [[ $GIT_OR_STOW_INSTALLED -eq 0 ]]; then
    exit 1
fi

# Dotfiles - deploy repo if not already done

# Validate git connection
echo "Checking git connection..."
git ls-remote $DOTFILES_REPO > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "Unable to connect to repo or git."
    exit 1
fi
echo "Connected to git."

echo 'Checking dotfiles directory exists'
if [[ ! -d $HOME/$DOTFILES_REPO_NAME ]]; then
    echo "Dotfiles directory doesn't exist, creating it."
    git clone $DOTFILES_REPO $HOME/$DOTFILES_REPO_NAME
    if [[ $? -ne 0 ]]; then
        echo "Failed to clone repository"
        exit 1
    fi
fi
echo 'Dotfiles directory exists.'

if [[ ! -d $HOME/$DOTFILES_REPO_NAME/.git ]]; then
    echo 'Dotfiles exists but is not a git repo, exiting...'
    exit 1
fi
echo "Dotfiles directory is a git repo."

# Dotfiles - run internal setup script
$HOME/$DOTFILES_REPO_NAME/setup/main.sh

# utils-and-scripts

# Validate git connection
echo "Checking git connection..."
git ls-remote $UTILS_AND_SCRIPTS_REPO > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "Unable to connect to repo or git."
    exit 1
fi
echo "Connected to git."

echo 'Checking uitils and scripts directory exists'
if [[ ! -d $HOME/$UTILS_AND_SCRIPTS_REPO_NAME ]]; then
    echo "Dotfiles directory doesn't exist, creating it."
    git clone $UTILS_AND_SCRIPTS_REPO $HOME/$UTILS_AND_SCRIPTS_REPO_NAME
    if [[ $? -ne 0 ]]; then
        echo "Failed to clone repository"
        exit 1
    fi
fi
echo 'Dotfiles directory exists.'

if [[ ! -d $HOME/$UTILS_AND_SCRIPTS_REPO_NAME/.git ]]; then
    echo 'Dotfiles exists but is not a git repo, exiting...'
    exit 1
fi
echo "Dotfiles directory is a git repo."

# utils-and-scripts - run internal setup script
$HOME/$UTILS_AND_SCRIPTS_REPO_NAME/linux/setup/main.sh

