# <a id="my-dot-files"></a>My dot files #

Designed for my own use, but feel free to use and submit issues and suggestions. I would be glad to know that it helped anyone besides me.

## <a id="os"></a>Requirements

This setup is specifically created for use with [Ubuntu 14.04 LTS Trusty Tahr (AMD64)](http://releases.ubuntu.com/trusty/), to use with other versions or distributions just replace the [APT](https://en.wikipedia.org/wiki/Advanced_Packaging_Tool) calls and the [Ubuntu repositories and packages](https://help.ubuntu.com/community/Repositories/Ubuntu).

All commands below are meant to run on [bash](https://en.wikipedia.org/wiki/Bash_\(Unix_shell\)) (default shell on Ubuntu). Open a terminal with <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>t</kbd>. To open bash (if `echo $0` doesn't print `bash`):

    /usr/bin/env bash

## <a id="install-software"></a>Install required software

<a id="ppa"></a>Add software sources to install software that are not from Canonical:

    # Enable partner
    sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

    # Enable proposed
    echo 'deb http://br.archive.ubuntu.com/ubuntu/ trusty-proposed universe main restricted multiverse' | sudo tee -a /etc/apt/sources.list

    # Add ppa's
    sudo add-apt-repository -y ppa:fish-shell/nightly-master
    sudo add-apt-repository -y ppa:chris-lea/node.js
    sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
    sudo add-apt-repository -y ppa:skype-wrapper/ppa
    sudo add-apt-repository -y ppa:bartbes/love-stable
    sudo add-apt-repository -y ppa:danjaredg/jayatana
    sudo add-apt-repository -y ppa:webupd8team/atom

    # Heroku Toolbelt ppa
    wget -O- https://toolbelt.heroku.com/apt/release.key | sudo apt-key add -
    sudo add-apt-repository 'deb http://toolbelt.heroku.com/ubuntu ./'

    # Opera ppa
    wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
    sudo add-apt-repository 'deb http://deb.opera.com/opera/ stable non-free'

    # Google Talk Plugin ppa
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo add-apt-repository 'deb http://dl.google.com/linux/talkplugin/deb/ stable main'

    # Virtual box
    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    sudo add-apt-repository 'deb http://download.virtualbox.org/virtualbox/debian saucy contrib'

<a id="apt"></a>Install apt packages:

    # Update package list
    sudo apt-get update

    # Install this package first, because it requires manual interaction
    sudo apt-get install -y ttf-mscorefonts-installer

    # Install packages
    typeset -A pkgfor
    pkgfor[dev]="atom sublime-text-installer vim-gtk kdiff3-qt meld guake"
    pkgfor[draw]="gimp gimp-gmic gimp-plugin-registry pinta inkscape shutter"
    pkgfor[other]="fbreader virtualbox-4.3 vagrant"
    pkgfor[web]="chromium-browser opera google-talkplugin skype skype-wrapper pepperflashplugin-nonfree"
    pkgfor[shell]="fish xclip trash-cli curl vlc imagemagick graphviz heroku-toolbelt"
    pkgfor[vcs]="git git-svn mercurial"
    pkgfor[stack]="nodejs openjdk-7-jdk love lua5.1"
    pkgfor[build]="build-essential checkinstall autoconf automake libtool g++ gettext"
    pkgfor[db]="mongodb libsqlite3-dev postgresql libpq-dev"
    pkgfor[ubuntu]="ubuntu-restricted-extras gdebi apt-file python-software-properties p7zip-full p7zip-rar jayatana"
    pkgfor[mono]="mono-gmcs fsharp monodevelop"
    pkgfor[libs]="exuberant-ctags libqt4-dev libfreetype6-dev libreadline-dev libbz2-dev libncurses5-dev libssl-dev libxslt1-dev"

    pkgs1="${pkgfor[dev]} ${pkgfor[draw]} ${pkgfor[other]} ${pkgfor[web]}"
    pkgs2="${pkgfor[shell]} ${pkgfor[vcs]} ${pkgfor[stack]}"
    pkgs3="${pkgfor[build]} ${pkgfor[db]} ${pkgfor[ubuntu]}"
    pkgs4="${pkgfor[mono]} ${pkgfor[libs]}"

    sudo apt-get install -y $pkgs1 $pkgs2 $pkgs3 $pkgs4

    # Perform update
    sudo apt-get dist-upgrade -y

<a id="phantomjs"></a>Install [PhantomJS](http://phantomjs.org/) manually, since apt package is too old:

    PHANTOMJS=phantomjs-1.9.8-linux-x86_64
    curl -Ls https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOMJS.tar.bz2 | tar -xj
    sudo mv $PHANTOMJS /usr/local/lib/phantomjs
    sudo ln -s /usr/local/lib/phantomjs/bin/phantomjs /usr/local/bin/phantomjs

<a id="vagrant"></a>Install [Vagrant](http://www.vagrantup.com/) manually and add an [Ubuntu box](https://vagrantcloud.com/ubuntu/trusty64):

    wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb
    sudo dpkg -i vagrant_1.6.3_x86_64.deb
    rm vagrant_1.6.3_x86_64.deb
    vagrant box add ubuntu/trusty64

<a id="virtualbox"></a>Configure [VirtualBox](https://www.virtualbox.org/):

    # Download and Install VirtualBox Extension Pack
    wget http://download.virtualbox.org/virtualbox/4.3.6/Oracle_VM_VirtualBox_Extension_Pack-4.3.6-91406.vbox-extpack
    VBoxManage extpack install *.vbox-extpack
    rm *.vbox-extpack

## <a id="configure-development-environment"></a>Configure workspace

<a id="ssh"></a>Configure SSH key:

    # Generate SSH key
    ssh-keygen -t rsa -C "michelpm@gmail.com"

    # Copy to clipboard
    xclip -sel clip < ~/.ssh/id_rsa.pub

<a id="ssh-github"></a>To upload to [Github](https://github.com/), go to [Account settings](https://github.com/settings/ssh), click 'Add SSH key', paste in the 'Key' text field and click in 'Add key'.

<a id="ssh-heroku"></a>To upload the key to [Heroku](http://www.heroku.com/), use the [Heroku Toolbelt](https://toolbelt.herokuapp.com/):

    # Login
    heroku login

    # Remove previous keys if you are not using them anymore, you may use also `keys:remove`
    heroku keys:clear

    # Upload
    heroku keys:add

<a id="configure-workspace"></a>Configure workspace:

    # Create empty folders on the workspace
    mkdir -p ~/ws/{etc,st3,rb,js}

    # Clone this repository
    git clone git@github.com:mmacedo/dotfiles.git ~/dotfiles

## <a id="configure-programming-stacks"></a>Configure programming stacks

<a id="ruby"></a><a id="rbenv"></a>Install several [rbenv](https://github.com/sstephenson/rbenv) plugins with [rbenv-installer](https://github.com/fesplugas/rbenv-installer) and build the latest [MRI/CRuby](http://www.ruby-lang.org/):

    # Stop errors when on system ruby
    sudo gem install bundler

    # Run rbenv-installer
    curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash

    # Copy Ruby dotfiles
    for rc in ~/dotfiles/{irb,pry,gem}rc; do ln -s $rc ~/.${rc##*/}; done

    # Load rbenv to install ruby
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    # Install dependencies for ruby
    rbenv bootstrap-ubuntu-12-04

    # Install latest MRI
    env RUBY_CONFIGURE_OPTS=--with-readline-dir="/usr/lib/libreadline.so" rbenv install 2.2.1
    rbenv global 2.2.1

    # Install gems
    gem update --system
    gem install bundler
    rbenv rehash
    pushd ~/dotfiles; bundle install; popd

<a id="pyenv"></a><a id="python"></a>Install [pyenv](https://github.com/yyuu/pyenv) and build the latest [Python](http://www.python.org/):

    # Install pyenv
    git clone http://github.com/yyuu/pyenv ~/.pyenv

    # Load pyenv to install python
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"

    # Install python 2
    sudo apt-get build-dep -y python2.7
    pyenv install 2.7.9
    pyenv shell 2.7.9
    pip install ipython

    # Install latest python
    sudo apt-get build-dep -y python3.4
    pyenv install 3.4.2
    pyenv global 3.4.2
    pyenv shell 3.4.2
    pip install ipython

<a id="node"></a><a id="nodejs"></a><a id="ndenv"></a>Install [ndenv](https://github.com/riywo/ndenv) and install the latest [Node.js](http://nodejs.org/):

    # Install ndenv
    git clone http://github.com/riywo/ndenv ~/.ndenv

    # Install node-build
    git clone http://github.com/riywo/node-build ~/.ndenv/plugins/node-build

    # Load ndenv to install node
    export PATH="$HOME/.ndenv/bin:$PATH"
    eval "$(ndenv init -)"

    # Install latest node
    ndenv install v0.12.0
    ndenv global v0.12.0

    # Install global packages
    npm install -global coffee-script bower

<a id="scala"></a>Install [sbt](http://www.scala-sbt.org/) and [scala](http://www.scala-lang.org/):

    # Install scala
    wget http://www.scala-lang.org/files/archive/scala-2.11.4.tgz
    tar zxf scala-2.11.4.tgz
    sudo mv scala-2.11.4 /usr/local/share/scala
    rm scala-2.11.4.tgz

    # Add links to the path
    sudo ln -s /usr/local/share/scala/bin/scala /usr/local/bin/scala
    sudo ln -s /usr/local/share/scala/bin/scalac /usr/local/bin/scalac
    sudo ln -s /usr/local/share/scala/bin/fsc /usr/local/bin/fsc
    sudo ln -s /usr/local/share/scala/bin/scaladoc /usr/local/bin/scaladoc
    sudo ln -s /usr/local/share/scala/bin/scalap /usr/local/bin/scalap

    # Install sbt
    wget https://dl.bintray.com/sbt/debian/sbt-0.13.7.deb
    sudo dpkg -i sbt-0.13.7.deb
    rm sbt-0.13.7.deb

## <a id="install-and-configure-text-editors-and-ides"></a>Configure applications

<a id="guake"></a>Configure [Guake](http://guake.org/).

    gconftool-2 --load ~/dotfiles/guake-preferences.xml

<a id="st2"></a>Configure [Sublime Text 3](http://www.sublimetext.com/) and install [Sublime Package Control](http://wbond.net/sublime_packages/package_control) and [URL handler](http://blog.byscripts.info/2013/02/txmt-protocol-and-sublime-text-2-english.html). First time you open Sublime Text 3 after doing these steps, Sublime Text 2 will install Sublime Package Control. First time it opens after that, Sublime Package Control is going to read my list of packages and install every one of them, but it is going to generate several errors and may need a few restarts until it finishes. Also, do not forget to enter license.

    # Copy configuration
    mkdir -p ~/.config/sublime-text-3/Packages/User
    rm ~/.config/sublime-text-3/Packages/User/{Preferences.sublime-settings,Default\ \(Linux\).sublime-keymap}
    for file in ~/dotfiles/st2/*; do ln -s "$file" ~/.config/sublime-text-3/Packages/User/; done

    # Install package_control package
    mkdir -p ~/.config/sublime-text-3/Installed\ Packages
    curl http://sublime.wbond.net/Package%20Control.sublime-package > ~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package

    # Install url handler for txtm:// and subl:// with Sublime Text 3
    wget https://raw.github.com/MrZYX/PKGBUILDs/master/sublime-url-handler/sublime-url-handler
    chmod +x sublime-url-handler
    sudo mv sublime-url-handler /usr/local/bin/
    wget https://raw.github.com/MrZYX/PKGBUILDs/master/sublime-url-handler/sublime-url-handler.desktop
    sudo mv sublime-url-handler.desktop /usr/local/share/applications/
    sudo update-desktop-database

<a id="vim"></a><a id="janus"></a>Install a [Vim](http://www.vim.org/) [distribution](https://github.com/carlhuda/janus) (need the ruby in the path to have rake installed). I don't pay much to attention to it, since I use it mainly to edit git commit messages.

    curl -Lo- https://bit.ly/janus-bootstrap | bash
    ln -s ~/dotfiles/vimrc.before ~/.vimrc.before

## <a id="configure-command-line-tools"></a>Configure command line tools

<a id="ack"></a>Install and configure [ack](http://betterthangrep.com/):

    curl http://beyondgrep.com/ack-2.04-single-file | sudo tee /usr/local/bin/ack
    sudo chmod 0755 /usr/local/bin/ack
    ln -s ~/dotfiles/ackrc ~/.ackrc

<a id="git"></a>Configure [git](http://git-scm.com/):

    ln -s ~/dotfiles/gitconfig ~/.gitconfig

<a id="hg"></a>Configure [hg](http://mercurial.selenic.com/):

    hg clone http://bitbucket.org/sjl/hg-prompt/
    ln -s ~/dotfiles/hgrc ~/.hgrc

<a id="fish"></a>Configure [fish](http://fishshell.com/):

    chsh -s $(which fish)
    curl -L https://raw.github.com/bpinto/oh-my-fish/master/tools/install.fish | fish
    mkdir -p ~/.config/fish && rm ~/.config/fish/config.fish && ln -s ~/dotfiles/config.fish ~/.config/fish/
    mkdir -p ~/.oh-my-fish/themes/my && ln -s ~/dotfiles/fish_prompt.fish ~/.oh-my-fish/themes/my/
