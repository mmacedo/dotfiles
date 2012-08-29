# My dot files #

Designed for my own use.

## Requirements ##

 * bash
 * git
 * curl
 * zsh
 * oh-my-zsh
 * rbenv
 * rbenv-build
 * rbenv-installer
 * python
 * setuptools
 * node
 * build-essential

## Apps ##

 * Guake (Ubuntu)
 * iTerm (OS X)
 * Sublime Text 2
   * package_control
   * sublime-theme-railscasts
   * phoenix-theme
 * FBReader
 * Chromium

## Git Bash (Windows) ##

    rbenv install 1.9.3-p194
    rbenv global 1.9.3-p194
    gem install rubygems bundler pry pry-exception_explorer hirb awesome_print map_by_method
    rbenv rehash
    cp -f profile ~/.profile
    cp -f pryrc ~/.pryrc
    cp -f irbrc ~/.irbrc
    cp -rf rails ~/.rails
    cp -f gitconfig ~/.gitconfig
    . ~/.profile

## OS X ##

    rbenv install 1.9.3-p194
    rbenv global 1.9.3-p194
    sudo gem install rubygems bundler pry pry-exception_explorer hirb awesome_print map_by_method
    rbenv rehash
    cp pryrc ~/.pryrc
    cp irbrc ~/.irbrc
    cp rails ~/.rails
    cp gitconfig ~/.gitconfig
    cp zshrc ~/.zshrc
    sudo easy_install pip
    sudo pip install virtualenv virtualenvwrapper
    cp npmrc ~/.npmrc
    cp config/sublime-text-2/Packages/User/Preferences.sublime-settings ~/.config/sublime-text-2/Packages/User/Preferences.sublime-settings
    . ~/.zshrc

## Ubuntu ##

    rbenv install 1.9.3-p194
    rbenv global 1.9.3-p194
    gem install rubygems bundler pry pry-exception_explorer hirb awesome_print map_by_method
    rbenv rehash
    cp pryrc ~/.pryrc
    cp irbrc ~/.irbrc
    cp rails ~/.rails
    cp gitconfig ~/.gitconfig
    cp zshrc ~/.zshrc
    sudo easy_install pip
    sudo pip install virtualenv virtualenvwrapper
    cp npmrc ~/.npmrc
    cp config/sublime-text-2/Packages/User/Preferences.sublime-settings ~/.config/sublime-text-2/Packages/User/Preferences.sublime-settings
    . ~/.zshrc