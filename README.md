# My dot files #

Designed for my own use.

## OS

Ubuntu 12.10 Quantal Quetzal

## Setup

```shell
# Add ppa's
sudo add-apt-repository ppa:chris-lea/node.js
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo add-apt-repository ppa:skype-wrapper/ppa

# Opera
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'

# Google Talk Plugin
curl -O https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
sudo dpkg -i google-talkplugin_current_amd64.deb && rm google-talkplugin_current_amd64.deb

# Typesafe (Scala)
curl -O http://apt.typesafe.com/repo-deb-build-0002.deb
sudo dpkg -i repo-deb-build-0002.deb && rm repo-deb-build-0002.deb

# Install packages
sudo apt-get update
# need UI interaction here
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y aptitude build-essential zsh autojump curl openjdk-7-jdk vim-gtk chromium-browser opera libqt4-webkit:i386 djview-plugin qbittorrent vlc audacious guake ubuntu-restricted-extras p7zip-full p7zip-rar sublime-text python-software-properties nodejs npm rbenv mongodb libsqlite3-dev postgresql libpq-dev fonts-inconsolata git fbreader libxslt-dev libxml2-dev libxml2-utils python-setuptools meld graphviz racket typesafe-stack xclip libqt4-dev make checkinstall libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev asciidoc libreadline-dev libsvn-perl libfreetype6-dev

# PhantomJS
PHANTOMJS=phantomjs-1.8.1-linux-x86_64
curl http://phantomjs.googlecode.com/files/$PHANTOMJS.tar.bz2 | tar -xj
sudo mv $PHANTOMJS /usr/lib/$PHANTOMJS
sudo ln -s /usr/local/lib/$PHANTOMJS /usr/lib/phantomjs
sudo ln -s /usr/lib/phantomjs/bin/phantomjs /usr/bin/phantomjs

# Skype
curl -o skype.deb http://download.skype.com/linux/skype-ubuntu-lucid_4.1.0.20-1_i386.deb
sudo dpkg -i skype.deb && rm skype.deb
sudo apt-get install -y skype-wrapper

# Remove unwanted packages and update
sudo apt-get purge -y unity-lens-shopping ubuntuone-client* python-ubuntuone-* totem deja-dup rhythmbox transmission* thunderbird
sudo apt-get update
sudo apt-get upgrade -y

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
sudo apt-get remove -y git git-man
cd git
make prefix=/usr/local all
sudo checkinstall --pkgname=git make prefix=/usr/local install
cd contrib/subtree
make prefix=/usr/local
sudo checkinstall --pkgname=git-subtree make prefix=/usr/local install
sudo checkinstall --pkgname=git-subtree-doc make prefix=/usr/local install-doc
cd ../../..

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
mkdir ~/scalaide/configuration/.settings && cp $DOTFILES/scalaide/org.eclipse.ui.ide.prefs ~/scalaide/configuration/.settings/org.eclipse.ui.ide.prefs

# Install ADT bundle
curl -O http://dl.google.com/android/adt/adt-bundle-linux-x86_64.zip
unzip adt-bundle-linux-x86_64.zip && rm adt-bundle-linux-x86_64.zip
mv adt-bundle-linux-x86_64 ~/adt
cp $DOTFILES/local/share/applications/adt.desktop ~/.local/share/applications/adt.desktop
mkdir ~/adt/eclipse/configuration/.settings && cp $DOTFILES/adt/org.eclipse.ui.ide.prefs ~/adt/eclipse/configuration/.settings/org.eclipse.ui.ide.prefs

# Python
sudo easy_install pip
sudo pip install virtualenv virtualenvwrapper

# Node.js
sudo npm install -global coffee-script underscore lodash express node-inspector bower

# Ruby (part 1: rbenv and plugins)
curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
SAFEGEMS="bundler ruby-graphviz rake thor mongoid pg guard execjs rails haml-rails coffee-rails devise less-rails-bootstrap rspec-rails factory_girl_rails database_cleaner jasminerice poltergeist"

# oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | dash
chsh -s /bin/zsh
cp $DOTFILES/zshrc ~/.zshrc
/bin/zsh

# Heroku Toolbelt (it will modify .zshrc)
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | dash
heroku login
heroku keys:clear
heroku keys:add

# Ruby (part 2: MRI)
sudo rbenv bootstrap-ubuntu-12-04
rbenv install 1.9.3-p362
rbenv global 1.9.3-p362
rbenv rehash
gem update --system
gem install $(echo $SAFEGEMS therubyracer bson_ext yajl-ruby twitter-bootstrap-rails)
gem update

# gVim
curl -Lo- https://bit.ly/janus-bootstrap | bash

# Ruby (part 3: JRuby)
rbenv install jruby-1.7.2
rbenv shell jruby-1.7.2
rbenv rehash
gem update --system
gem install $(echo $SAFEGEMS therubyrhino jruby-openssl)
gem update
```
