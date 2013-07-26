#!/usr/bin/env bash

OPTIONS=$@

echo No output means no differences.

# Go to dotfiles repository
DOTFILES=$(dirname $(dirname $(readlink -f $0)))

# Diff Sublime Text 2 Configuration
diff --exclude "*.last-run" --exclude "Default (*).sublime-keymap" ~/.config/sublime-text-2/Packages/User $DOTFILES/st2 $OPTIONS

# Diff fish configuration
diff ~/.config/fish/config.fish $DOTFILES/config.fish $OPTIONS
diff ~/.config/fish/source.fish $DOTFILES/source.fish $OPTIONS
diff ~/.config/fish/functions.fish $DOTFILES/functions.fish $OPTIONS

# Diff git configuration
diff ~/.gitconfig $DOTFILES/gitconfig $OPTIONS

# Diff ack configuration
diff ~/.ackrc $DOTFILES/ackrc $OPTIONS

# Diff ruby configuration
diff ~/.gemrc $DOTFILES/gemrc $OPTIONS
diff ~/.irbrc $DOTFILES/irbrc $OPTIONS
diff ~/.pryrc $DOTFILES/pryrc $OPTIONS
