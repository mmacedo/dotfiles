#!/usr/bin/env sh

OPTIONS=$@

echo No output means no differences.

# Go to dotfiles repository
DOTFILES=$(dirname $(dirname $(readlink -f $0)))

# Diff Sublime Text 2 Configuration
diff --exclude "*.last-run" --exclude "Default (*).sublime-keymap" $DOTFILES/st2 ~/.config/sublime-text-2/Packages/User $OPTIONS

# Diff zsh configuration
diff $DOTFILES/zshenv ~/.zshenv $OPTIONS
diff $DOTFILES/zshrc ~/.zshrc $OPTIONS

# Diff git configuration
diff $DOTFILES/gitconfig ~/.gitconfig $OPTIONS

# Diff ack configuration
diff $DOTFILES/ackrc ~/.ackrc $OPTIONS

# Diff ruby configuration
diff $DOTFILES/gemrc ~/.gemrc $OPTIONS
diff $DOTFILES/irbrc ~/.irbrc $OPTIONS
diff $DOTFILES/pryrc ~/.pryrc $OPTIONS

APPS=~/.local/share/applications
# Diff applications configuration
diff $DOTFILES/mimeapps.list $APPS/mimeapps.list $OPTIONS
diff $DOTFILES/adt/adt.desktop $APPS/adt.desktop $OPTIONS
diff $DOTFILES/adt/adt.desktop $APPS/adt.desktop $OPTIONS
diff $DOTFILES/adt/adt.xpm ~/adt/eclipse/icon.xpm $OPTIONS
