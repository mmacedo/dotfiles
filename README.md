# <a id="my-dot-files"></a>My dot files #

Designed for my own use, but feel free to use and submit issues and suggestions. I would be glad to know that it helped anyone besides me.


## <a id="os"></a>Requirements

This setup is specifically created for use with [Ubuntu 13.10 Saucy Salamander (AMD64)](http://releases.ubuntu.com/saucy/), to use with other versions or distributions just replace the [APT](https://en.wikipedia.org/wiki/Advanced_Packaging_Tool) calls and the [Ubuntu repositories and packages](https://help.ubuntu.com/community/Repositories/Ubuntu).

All commands below are meant to run on [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell\)) (default shell on Ubuntu). Open a terminal with <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>t</kbd>. To open bash (if `echo $0` doesn't print `bash`):

    /usr/bin/env bash


## <a id="install-software"></a>Install required software

<a id="ppa"></a>Add software sources to install software that are not from Canonical:

    # Enable Canonical Partner
    sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

    # Add ppa's
    sudo add-apt-repository -y ppa:fish-shell/nightly-master
    sudo add-apt-repository -y ppa:chris-lea/node.js
    sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
    sudo add-apt-repository -y ppa:skype-wrapper/ppa

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
    pkgfor[dev]="sublime-text vim-gtk kdiff3-qt meld guake"
    pkgfor[draw]="gimp gimp-gmic gimp-plugin-registry pinta inkscape shutter"
    pkgfor[other]="fbreader virtualbox-4.3"
    pkgfor[web]="opera google-talkplugin skype skype-wrapper"
    pkgfor[shell]="fish xclip trash-cli curl vlc imagemagick ffmpeg graphviz heroku-toolbelt"
    pkgfor[vcs]="git git-svn mercurial"
    pkgfor[stack]="nodejs openjdk-7-jdk"
    pkgfor[build]="build-essential checkinstall autoconf automake libtool g++ gettext"
    pkgfor[db]="mongodb libsqlite3-dev postgresql libpq-dev"
    pkgfor[ubuntu]="ubuntu-restricted-extras aptitude synaptic python-software-properties p7zip-full p7zip-rar"
    pkgfor[mono]="mono-gmcs apache2-dev libgtk2.0-dev libglade2-dev libglib2.0-dev libgnome2-dev libgnomeui-dev libgnomecanvas2-dev"
    pkgfor[libs]="exuberant-ctags libqt4-dev libfreetype6-dev libreadline-dev libbz2-dev libncurses5-dev libssl-dev libxslt1-dev"
    
    pkgs1="${pkgfor[dev]} ${pkgfor[draw]} ${pkgfor[other]} ${pkgfor[web]}"
    pkgs2="${pkgfor[shell]} ${pkgfor[vcs]} ${pkgfor[stack]}"
    pkgs3="${pkgfor[build]} ${pkgfor[db]} ${pkgfor[ubuntu]}"
    pkgs4="${pkgfor[mono]} ${pkgfor[libs]}"
    
    sudo apt-get install -y $pkgs1 $pkgs2 $pkgs3 $pkgs4

    # Perform full upgrade
    sudo apt-get dist-upgrade -y

    # Clean up
    sudo apt-get autoremove --purge -y
    sudo apt-get autoclean

<a id="phantomjs"></a>Install [PhantomJS](http://phantomjs.org/) manually, since apt package is too old:

    PHANTOMJS=phantomjs-1.9.1-linux-x86_64
    curl http://phantomjs.googlecode.com/files/$PHANTOMJS.tar.bz2 | tar -xj
    sudo mv $PHANTOMJS /usr/lib/phantomjs
    sudo ln -s /usr/lib/phantomjs/bin/phantomjs /usr/bin/phantomjs

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
    mkdir -p ~/ws/{clone,st2,ruby,nodejs}

    # Clone this repository
    git clone git@github.com:mmacedo/dotfiles.git ~/dotfiles


## <a id="configure-programming-stacks"></a>Configure programming stacks

<a id="ruby"></a><a id="rbenv"></a>Install several [rbenv](https://github.com/sstephenson/rbenv) plugins with [rbenv-installer](https://github.com/fesplugas/rbenv-installer) and build the latest [MRI/CRuby](http://www.ruby-lang.org/):

    # Run rbenv-installer
    curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash

    # Copy Ruby dotfiles
    for rc in ~/dotfiles/{irb,pry,gem}rc; do ln -s $rc ~/.${rc##*/}; done

    # Load rbenv to install ruby
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    # Install dependencies for ruby
    sudo rbenv bootstrap-ubuntu-12-10

    # Install latest MRI
    env CONFIGURE_OPTS="--with-readline-dir=/usr/include/readline" rbenv install 2.0.0-p353
    rbenv global 2.0.0-p353

    # Install gems
    gem update --system
    gem install bundler
    pushd ~/dotfiles; bundle install; popd

<a id="pyenv"></a><a id="python"></a>Install [pyenv](https://github.com/yyuu/pyenv) and build the latest [Python](http://www.python.org/):

    # Install pyenv
    git clone http://github.com/yyuu/pyenv ~/.pyenv

    # Load pyenv to install python
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"

    # Install python 2
    sudo apt-get build-dep -y python2.7
    pyenv install 2.7.6
    pyenv shell 2.7.6
    pip install ipython

    # Install latest python
    sudo apt-get build-dep -y python3.3
    pyenv install 3.3.2
    pyenv global 3.3.2
    pyenv shell 3.3.2
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
    ndenv install v0.11.4
    ndenv global v0.11.4
    ndenv rehash

    # Install global packages
    pushd ~/dotfiles; npm install -global; popd

<a id="mono"></a>Install [mono](http://www.mono-project.com/), [monodevelop](http://monodevelop.com/) and [f#](http://fsharp.org/):

    # Install libgdiplus (c50d1f96348b729aa01768b007cad64fb5937be2)
    git clone git://github.com/mono/libgdiplus.git
    pushd libgdiplus
    ./autogen.sh --prefix=/opt/mono
    make
    sudo make install
    popd

    # Install mono
    git clone git://github.com/mono/mono.git
    pushd mono
    git checkout mono-3.2.5
    ./autogen.sh --prefix=/opt/mono
    make
    sudo make install
    popd

    # Install xsp (d3a882a489d069adf93f50bec46216b65c72c5c6)
    git clone git://github.com/mono/xsp.git
    pushd xsp
    ./autogen.sh --prefix=/opt/mono
    make
    sudo make install
    popd

    # Install mod_mono (6b73e850920865b8f6a16f232e555c71ec1cd26a)
    git clone git://github.com/mono/mod_mono.git
    pushd mod_mono
    ./autogen.sh --prefix=/opt/mono
    make
    sudo make install
    echo \n"Include /etc/apache2/mod_mono.conf" | sudo tee -a /etc/apache2/apache2.conf >/dev/null
    sudo sed -i 's|AddType application/x-asp-net \.aspx|MonoServerPath /opt/mono/bin/mod-mono-server4\n\n&|' /etc/apache2/mod_mono.conf
    popd

    # Install fsharp
    git clone git://github.com/fsharp/fsharp.git
    pushd fsharp
    git checkout 3.0.31
    ./autogen.sh --prefix=/opt/mono
    make
    sudo make install
    popd

    # Install gtk-sharp (gtk#)
    git clone git://github.com/mono/gtk-sharp.git
    pushd gtk-sharp
    git checkout 2.12.22
    ./bootstrap-2.12 --prefix=/opt/mono
    make
    sudo make install
    popd

    # Install gnome-sharp (gtk#)
    git clone git://github.com/mono/gnome-sharp.git
    pushd gnome-sharp
    git checkout 2.24.1
    # Remove TestXfer.cs, TestXfer.exe and Mono.GetOptions from sample/gnomevfs/Makefile.am
    ./bootstrap-2.24 --prefix=/opt/mono
    make
    sudo make install
    popd

    # Install gnome-desktop-sharp (gtk#)
    git clone git://github.com/mono/gnome-desktop-sharp.git
    pushd gnome-desktop-sharp
    git checkout 2.24.0
    ./autogen.sh --prefix=/opt/mono
    make
    sudo make install
    popd

    # Install monodevelop
    git clone git://github.com/mono/monodevelop.git
    pushd monodevelop
    ./configure --prefix=/opt/mono
    make
    sudo make install
    popd
    cp ~/dotfiles/monodevelop.desktop ~/.local/share/applications/monodevelop.desktop

<a id="scala"></a>Install [sbt](http://www.scala-sbt.org/) and [scala](http://www.scala-lang.org/):

    # Install scala
    wget http://www.scala-lang.org/files/archive/scala-2.10.3.tgz
    tar zxf scala-2.10.3.tgz
    sudo mv scala-2.10.3 /usr/share/scala

    # Add links to the path
    sudo ln -s /usr/share/scala/bin/scala /usr/bin/scala
    sudo ln -s /usr/share/scala/bin/scalac /usr/bin/scalac
    sudo ln -s /usr/share/scala/bin/fsc /usr/bin/fsc
    sudo ln -s /usr/share/scala/bin/scaladoc /usr/bin/scaladoc
    sudo ln -s /usr/share/scala/bin/scalap /usr/bin/scalap

    # Install sbt
    wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.deb
    sudo dpkg -i sbt.deb
    rm sbt.deb

## <a id="install-and-configure-text-editors-and-ides"></a>Configure applications

<a id="guake"></a>Configure [Guake](http://guake.org/).

    gconftool-2 --load ~/dotfiles/guake-preferences.xml

<a id="st2"></a>Configure [Sublime Text 2](http://www.sublimetext.com/) and install [Sublime Package Control](http://wbond.net/sublime_packages/package_control) and [URL handler](http://blog.byscripts.info/2013/02/txmt-protocol-and-sublime-text-2-english.html). First time you open Sublime Text 2 after doing these steps, Sublime Text 2 will install Sublime Package Control. First time it opens after that, Sublime Package Control is going to read my list of packages and install every one of them, but it is going to generate several errors and may need a few restarts until it finishes. Also, do not forget to enter license.

    # Copy configuration
    mkdir -p ~/.config/sublime-text-2/Packages/User
    for file in ~/dotfiles/st2/*; do ln -s "$file" ~/.config/sublime-text-2/Packages/User/; done

    # Install package_control package
    mkdir -p ~/.config/sublime-text-2/Installed\ Packages
    curl http://sublime.wbond.net/Package%20Control.sublime-package > ~/.config/sublime-text-2/Installed\ Packages/Package\ Control.sublime-package

    # Install url handler for txtm:// and subl:// with Sublime Text 2
    wget https://raw.github.com/MrZYX/PKGBUILDs/master/sublime-url-handler/sublime-url-handler
    chmod +x sublime-url-handler
    sudo mv sublime-url-handler /usr/bin/
    wget https://raw.github.com/MrZYX/PKGBUILDs/master/sublime-url-handler/sublime-url-handler.desktop
    sudo mv sublime-url-handler.desktop /usr/share/applications/
    sudo update-desktop-database

<a id="vim"></a><a id="janus"></a>Install a [Vim](http://www.vim.org/) [distribution](https://github.com/carlhuda/janus) (need the ruby in the path to have rake installed). I don't pay much to attention to it, since I use it mainly to edit git commit messages.

    curl -Lo- https://bit.ly/janus-bootstrap | bash


## <a id="configure-command-line-tools"></a>Configure command line tools

<a id="ack"></a>Install and configure [ack](http://betterthangrep.com/):

    curl http://beyondgrep.com/ack-2.04-single-file > ~/bin/ack && chmod 0755 !#:3
    ln -s ~/dotfiles/ackrc ~/.ackrc

<a id="git"></a>Configure [git](http://git-scm.com/):

    ln -s ~/dotfiles/gitconfig ~/.gitconfig

<a id="hg"></a>Configure [hg](http://mercurial.selenic.com/):

    hg clone http://bitbucket.org/sjl/hg-prompt/
    ln -s ~/dotfiles/hgrc ~/.hgrc

<a id="fish"></a>Configure [fish](http://fishshell.com/):

    chsh -s $(which fish)
    curl -L https://github.com/bpinto/oh-my-fish/raw/master/tools/install.sh | bash
    mkdir -p ~/.config/fish && ln -s ~/dotfiles/config.fish ~/.config/fish/
    mkdir -p ~/.oh-my-fish/themes/my && ln -s ~/dotfiles/fish_prompt.fish ~/.oh-my-fish/themes/my/
