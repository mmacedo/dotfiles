# My dot files #

Designed for my own use.

## OS

Ubuntu 12.10 Quantal Quetzal

## Setup

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
    sudo apt-get update
    # need UI interaction here
    sudo apt-get install -y ttf-mscorefonts-installer
    sudo apt-get install -y build-essential zsh autojump curl openjdk-7-jdk vim-gtk chromium-browser djview-plugin qbittorrent vlc audacious guake ubuntu-restricted-extras p7zip-full p7zip-rar sublime-text opera python-software-properties nodejs npm phantomjs rbenv mongodb libsqlite3-dev fonts-inconsolata git fbreader libxslt-dev libxml2-dev libxml2-utils python-setuptools meld graphviz racket git-tf typesafe-stack xclip

    # Remove unwanted packages and update
    sudo apt-get purge -y unity-lens-shopping ubuntuone-client* python-ubuntuone-* totem deja-dup rhythmbox transmission*
    sudo apt-get update
    sudo apt-get upgrade -y

    # Setup SSH keys
    ssh-keygen -t rsa -C "michelpm@gmail.com"
    xclip -sel clip < ~/.ssh/id_rsa.pub
    # Add SSH key on GitHub

    # Setup workspace
    mkdir -p ~/ws/{rb,sc,js,other}
    git clone git@github.com:mmacedo/dotfiles.git ~/ws/other/dotfiles
    git clone git@github.com:mmacedo/mmacedo.github.com.git ~/ws/other/blog
    git clone git@github.com:mmacedo/euler.git ~/ws/other/euler

    # Sublime Text 2
    curl http://sublime.wbond.net/Package%20Control.sublime-package > ~/.config/sublime-text-2/Installed\ Packages/Package\ Control.sublime-package
    cp ~/ws/other/dotfiles/config/sublime-text-2/Packages/User/* ~/.config/sublime-text-2/Packages/User

    # Scala IDE
    curl http://downloads.typesafe.com.s3.amazonaws.com/scalaide-pack/2.1.0.m2-29-20121023/scala-SDK-2.1-M2-2.9-linux.gtk.x86_64.tar.gz | tar zx
    mv eclipse ~/scalaide
    cp ~/ws/other/dotfiles/local/share/applications/scalaide.desktop ~/.local/share/applications/scalaide.desktop
    cp ~/ws/other/dotfiles/scalaide/org.eclipse.ui.ide.prefs ~/scalaide/configuration/.settings/org.eclipse.ui.ide.prefs

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
    cp ~/ws/other/dotfiles/zshrc ~/.zshrc
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