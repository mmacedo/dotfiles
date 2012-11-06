# My dot files #

Designed for my own use.

## OS

Ubuntu 12.10 Quantal Quetzal

## Setup

    # Install apt-fast
    sudo add-apt-repository ppa:apt-fast/stable
    sudo apt-get update
    # need UI interaction here
    sudo apt-get install -y apt-fast

    # Add multiple repositories for apt
    # Empty the list, easier than sed'ing to remove and insert lines
    sudo rm /etc/apt/sources.list
    sudo touch /etc/apt/sources.list
    # Add repositories (closer to me)
    function addLineToSources () { echo "$@" | sudo tee -a /etc/apt/sources.list 1>/dev/null  }
    for url in http://mirror.globo.com/ubuntu/archive/ http://ubuntu.c3sl.ufpr.br/ubuntu/ http://espelhos.edugraf.ufsc.br/ubuntu/
    do
      addLineToSources
      addLineToSources "# $url"
      addLineToSources
      addLineToSources deb $url quantal main restricted
      addLineToSources deb-src $url quantal main restricted
      addLineToSources deb $url quantal-updates main restricted
      addLineToSources deb-src $url quantal-updates main restricted
      addLineToSources deb $url quantal universe
      addLineToSources deb-src $url quantal universe
      addLineToSources deb $url quantal-updates universe
      addLineToSources deb-src $url quantal-updates universe
      addLineToSources deb $url quantal multiverse
      addLineToSources deb-src $url quantal multiverse
      addLineToSources deb $url quantal-updates multiverse
      addLineToSources deb-src $url quantal-updates multiverse
      addLineToSources deb $url quantal-backports main restricted universe multiverse
      addLineToSources deb-src $url quantal-backports main restricted universe multiverse
      addLineToSources deb $url quantal-security main restricted
      addLineToSources deb-src $url quantal-security main restricted
      addLineToSources deb $url quantal-security universe
      addLineToSources deb-src $url quantal-security universe
      addLineToSources deb $url quantal-security multiverse
      addLineToSources deb-src $url quantal-security multiverse
    done
    # Add partner and ppa repositories
    addLineToSources
    addLineToSources "# Partners"
    addLineToSources
    addLineToSources "# deb http://archive.canonical.com/ubuntu quantal partner"
    addLineToSources "# deb-src http://archive.canonical.com/ubuntu quantal partner"
    addLineToSources
    addLineToSources "# PPA's"
    addLineToSources
    addLineToSources deb http://extras.ubuntu.com/ubuntu quantal main
    addLineToSources deb-src http://extras.ubuntu.com/ubuntu quantal main

    # Add ppa's
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo add-apt-repository ppa:webupd8team/sublime-text-2

    # Opera
    wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
    sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'

    # Typesafe (Scala)
    curl -O http://apt.typesafe.com/repo-deb-build-0002.deb
    sudo dpkg -i repo-deb-build-0002.deb
    rm repo-deb-build-0002.deb

    # Install packages
    sudo apt-fast update
    # need UI interaction here
    sudo apt-fast install -y ttf-mscorefonts-installer
    sudo apt-fast install -y build-essential zsh autojump curl openjdk-7-jdk vim-gtk chromium-browser djview-plugin qbittorrent vlc audacious guake ubuntu-restricted-extras p7zip-full p7zip-rar sublime-text opera python-software-properties nodejs npm phantomjs rbenv mongodb libsqlite3-dev fonts-inconsolata git fbreader libxslt-dev libxml2-dev libxml2-utils python-setuptools meld graphviz racket typesafe-stack xclip libqt4-dev make checkinstall libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev asciidoc

    # Remove unwanted packages and update
    sudo apt-fast purge -y unity-lens-shopping ubuntuone-client* python-ubuntuone-* totem deja-dup rhythmbox transmission* thunderbird
    sudo apt-fast update
    sudo apt-fast upgrade -y

    # Setup SSH keys
    ssh-keygen -t rsa -C "michelpm@gmail.com"
    xclip -sel clip < ~/.ssh/id_rsa.pub
    # Add SSH key on GitHub

    # Setup workspace
    DOTFILES=~/ws/other/dotfiles
    mkdir -p ~/ws/{rb,sc,js,other}
    git clone git@github.com:mmacedo/dotfiles.git $DOTFILES
    git clone git@github.com:mmacedo/mmacedo.github.com.git ~/ws/other/blog
    git clone git@github.com:mmacedo/euler.git ~/ws/other/euler

    # Build git and git-subtree from source
    git clone https://github.com/git/git
    sudo apt-fast remove -y git git-man
    cd git
    make prefix=/usr/local all
    sudo checkinstall --pkgname=git make prefix=/usr/local install
    cd contrib/subtree
    make prefix=/usr/local
    sudo checkinstall --pkgname=git-subtree make prefix=/usr/local install
    sudo checkinstall --pkgname=git-subtree-doc make prefix=/usr/local install-doc
    ../../..

    # Install git-tf
    # Get latest from http://gittf.codeplex.com/
    unzip -j -o -d git-tf git-tf-1.0.1.20120827.zip
    rm git-tf-1.0.1.20120827.zip
    sed -i '2i\GITTF_HOME="/usr/lib/git-tf"' git-tf/git-tf
    sudo mv git-tf /usr/lib/
    sudo ln -s /usr/lib/git-tf/git-tf /usr/bin/git-tf

    # Sublime Text 2
    curl http://sublime.wbond.net/Package%20Control.sublime-package > ~/.config/sublime-text-2/Installed\ Packages/Package\ Control.sublime-package
    cp $DOTFILES/config/sublime-text-2/Packages/User/* ~/.config/sublime-text-2/Packages/User

    # Install Scala IDE
    curl http://downloads.typesafe.com.s3.amazonaws.com/scalaide-pack/2.1.0.m2-29-20121023/scala-SDK-2.1-M2-2.9-linux.gtk.x86_64.tar.gz | tar zx
    mv eclipse ~/scalaide
    cp $DOTFILES/local/share/applications/scalaide.desktop ~/.local/share/applications/scalaide.desktop
    cp $DOTFILES/scalaide/org.eclipse.ui.ide.prefs ~/scalaide/configuration/.settings/org.eclipse.ui.ide.prefs

    # Python
    sudo easy_install pip
    sudo pip install virtualenv virtualenvwrapper

    # Node.js
    sudo npm install -global coffee-script underscore express node-inspector bower

    # Ruby (part 1: rbenv and plugins)
    curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
    SAFEGEMS="bundler rake thor rails_apps_composer rails sinatra puma mongoid guard guard-livereload rack-livereload devise simple_form inherited_resources has_scope kaminari haml-rails less-rails-bootstrap coffee-rails rspec-rails factory_girl_rails database_cleaner jasminerice poltergeist execjs reek brakeman simplecov ruby-graphviz"

    # oh-my-zsh
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    chsh -s /bin/zsh
    cp $DOTFILES/zshrc ~/.zshrc
    /bin/zsh

    # Ruby (part 2: MRI)
    sudo rbenv bootstrap-ubuntu-12-04
    rbenv install 1.9.3-p286
    rbenv global 1.9.3-p286
    rbenv rehash
    gem update --system
    gem install $(echo $SAFEGEMS therubyracer bson_ext yajl-ruby pry pry-exception_explorer awesome_print map_by_method twitter-bootstrap-rails)
    gem update

    # gVim
    curl -Lo- https://bit.ly/janus-bootstrap | bash

    # Ruby (part 3: JRuby)
    rbenv install jruby-1.7.0
    rbenv shell jruby-1.7.0
    rbenv rehash
    gem update --system
    gem install $(echo $SAFEGEMS therubyrhino jruby-openssl)
    gem update