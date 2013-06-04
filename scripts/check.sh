#!/usr/bin/env sh

OPTIONS=$@

echo No output means no differences.

# Go to dotfiles repository
DOTFILES=$(dirname $(dirname $(readlink -f $0)))

# Diff Sublime Text 2 Configuration
diff --exclude "*.last-run" --exclude "Default (*).sublime-keymap" ~/.config/sublime-text-2/Packages/User $DOTFILES/st2 $OPTIONS

# Diff zsh configuration
diff ~/.zshenv $DOTFILES/zshenv $OPTIONS
diff ~/.zshrc $DOTFILES/zshrc $OPTIONS

# Diff git configuration
diff ~/.gitconfig $DOTFILES/gitconfig $OPTIONS

# Diff ack configuration
diff ~/.ackrc $DOTFILES/ackrc $OPTIONS

# Diff ruby configuration
diff ~/.gemrc $DOTFILES/gemrc $OPTIONS
diff ~/.irbrc $DOTFILES/irbrc $OPTIONS
diff ~/.pryrc $DOTFILES/pryrc $OPTIONS

APPS=~/.local/share/applications
# Diff applications configuration
diff $APPS/mimeapps.list $DOTFILES/mimeapps.list $OPTIONS
