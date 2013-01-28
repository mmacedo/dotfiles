#!/usr/bin/env ruby

# Go to dotfiles repository
Dir.chdir File.expand_path(File.dirname(File.dirname(__FILE__)))

# Diff Sublime Text 2 Configuration
puts `diff --exclude "*.last-run" --exclude "Default (*).sublime-keymap" st2 ~/.config/sublime-text-2/Packages/User`

# Diff zsh configuration
puts `diff zshenv ~/.zshenv`
puts `diff zshrc ~/.zshrc`

# Diff git configuration
puts `diff gitconfig ~/.gitconfig`