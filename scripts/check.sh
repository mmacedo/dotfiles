#!/usr/bin/env sh

echo No output means no differences.

# Go to dotfiles repository
DOTFILES=$(dirname $(dirname $(readlink -f $0)))

# Diff Sublime Text 2 Configuration
diff --exclude "*.last-run" --exclude "Default (*).sublime-keymap" $DOTFILES/st2 ~/.config/sublime-text-2/Packages/User

# Diff zsh configuration
diff $DOTFILES/zshenv ~/.zshenv
diff $DOTFILES/zshrc ~/.zshrc

# Diff git configuration
diff $DOTFILES/gitconfig ~/.gitconfig

# Diff ack configuration
diff $DOTFILES/ackrc ~/.ackrc

# Diff ruby configuration
diff $DOTFILES/gemrc ~/.gemrc
diff $DOTFILES/irbrc ~/.irbrc
diff $DOTFILES/pryrc ~/.pryrc

APPS=~/.local/share/applications
# Diff applications configuration
diff $DOTFILES/mimeapps.list $APPS/mimeapps.list
diff $DOTFILES/adt/adt.desktop $APPS/adt.desktop
diff $DOTFILES/adt/adt.desktop $APPS/adt.desktop
diff $DOTFILES/adt/adt.xpm ~/adt/eclipse/icon.xpm
