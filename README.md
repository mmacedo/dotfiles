# My dot files #

Designed for my own use.

## OS

Ubuntu 13.04 Raring Ringtail (x86_64)

## Setup

```shell
# Enable partner
sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

# Add ppa's
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo add-apt-repository -y ppa:skype-wrapper/ppa

# Erlang/OTP ppa
wget -O - http://binaries.erlang-solutions.com/debian/erlang_solutions.asc | sudo apt-key add -
echo "deb http://binaries.erlang-solutions.com/debian quantal contrib" | sudo tee -a /etc/apt/sources.list.d/esl.list

# Heroku Toolbelt ppa
wget -O- https://toolbelt.heroku.com/apt/release.key | apt-key add -
echo "deb http://toolbelt.heroku.com/ubuntu ./" | sudo tee /etc/apt/sources.list.d/heroku.list

# Opera ppa
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
echo "deb http://deb.opera.com/opera/ stable non-free" | sudo tee /etc/apt/sources.list.d/opera.list

# Google Talk Plugin ppa
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list

# Typesafe (Scala) ppa
wget http://apt.typesafe.com/repo-deb-build-0002.deb
sudo dpkg -i repo-deb-build-0002.deb && rm repo-deb-build-0002.deb

# Install packages
typeset -A pkgfor
pkgfor[app]="fbreader sublime-text vim-gtk racket meld guake"
pkgfor[build]="build-essential checkinstall"
pkgfor[db]="mongodb libsqlite3-dev postgresql libpq-dev"
pkgfor[font]="fonts-inconsolata"
pkgfor[git]="git git-svn gitstats gitk"
pkgfor[media]="qbittorrent vlc audacious"
pkgfor[shell]="zsh ack-grep autojump xclip curl imagemagick heroku-toolbelt"
pkgfor[stack]="python-setuptools typesafe-stack nodejs npm rbenv openjdk-7-jdk esl-erlang"
pkgfor[ubuntu]="ubuntu-restricted-extras aptitude synaptic python-software-properties p7zip-full p7zip-rar"
pkgfor[x64]="ia32-libs"
pkgfor[web]="chromium-browser chromium-codecs-ffmpeg-extra opera djview-plugin google-talkplugin skype skype-wrapper"
sudo apt-get update
# need UI interaction here
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y ${pkgfor[app]} ${pkgfor[build]} ${pkgfor[db]} ${pkgfor[font]} ${pkgfor[git]} ${pkgfor[media]} ${pkgfor[shell]} ${pkgfor[stack]} ${pkgfor[ubuntu]} ${pkgfor[x64]} ${pkgfor[web]} graphviz libxslt-dev libxml2-dev libxml2-utils libqt4-dev libreadline-dev libfreetype6-dev

# PhantomJS
PHANTOMJS=phantomjs-1.8.1-linux-x86_64
curl http://phantomjs.googlecode.com/files/$PHANTOMJS.tar.bz2 | tar -xj
sudo mv $PHANTOMJS /usr/lib/phantomjs
sudo ln -s /usr/lib/phantomjs/bin/phantomjs /usr/bin/phantomjs

# elixir
git clone https://github.com/elixir-lang/elixir -b stable
cd elixir && make test && cd ..

# expm
curl -O http://expm.co/__download__/expm && chmod +x expm
sudo mv expm /usr/bin/expm

# Remove unwanted packages, update and clean up
sudo apt-get purge -y unity-lens-shopping ubuntuone-client* python-ubuntuone-* totem deja-dup rhythmbox transmission* thunderbird
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove --purge -y
sudo apt-get autoclean

# Setup SSH key
ssh-keygen -t rsa -C "michelpm@gmail.com"

# Upload key to Github
xclip -sel clip < ~/.ssh/id_rsa.pub
nohup xdg-open https://github.com/settings/ssh &>/dev/null
# Click 'Add SSH key', paste to 'Key' and click 'Add key'
nohup xdg-open https://mail.google.com/mail/u/0/#inbox &>/dev/null
# Confirm key

# Upload key to Heroku
heroku login
heroku keys:clear
heroku keys:add

# Setup workspace
DOTFILES=~/ws/etc/dotfiles
mkdir -p ~/ws/{etc,clone,rb,js,st2,sc,adt}
git clone git@github.com:mmacedo/dotfiles.git $DOTFILES
git clone git@github.com:mmacedo/mmacedo.github.com.git ~/ws/etc/blog
git clone git@github.com:mmacedo/euler.git ~/ws/etc/euler

# Configure default applications
sudo update-alternatives --set x-www-browser /usr/bin/chromium-browser
sudo update-alternatives --set gnome-www-browser /usr/bin/chromium-browser
cp $DOTFILES/mimeapps.list ~/.local/share/applications

# Configure ack
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
cp $DOTFILES/ackrc ~/.ackrc

# Configure git
cp $DOTFILES/gitconfig ~/.gitconfig

# Install git-tf
GITTF=git-tf-2.0.1.20130107
wget http://download.microsoft.com/download/A/E/2/AE23B059-5727-445B-91CC-15B7A078A7F4/$GITTF.zip
unzip $GITTF.zip && mv $GITTF git-tf && rm $GITTF.zip
sed -i 's/dirname "$0"/dirname "$(readlink -f $0)"/' git-tf/git-tf
sudo mv git-tf /usr/lib/
sudo ln -s /usr/lib/git-tf/git-tf /usr/bin/git-tf

# Sublime Text 2
ST2=~/.config/sublime-text-2
mkdir -p $ST2/{Installed\ Packages,Packages/User}
curl http://sublime.wbond.net/Package%20Control.sublime-package > $ST2/Installed\ Packages/Package\ Control.sublime-package
cp $DOTFILES/st2/* $ST2/Packages/User
# Open Sublime Text and wait a bunch of minutes for package_control to install all packages

# Install Scala IDE
curl http://downloads.typesafe.com.s3.amazonaws.com/scalaide-pack/2.1.0.m2-29-20121023/scala-SDK-2.1-M2-2.9-linux.gtk.x86_64.tar.gz | tar zx
mv eclipse ~/scalaide
convert ~/scalaide/icon.xpm -resize 48x48 ~/scalaide/icon.xpm
mkdir -p ~/.local/share/applications && cp $DOTFILES/scalaide/scalaide.desktop ~/.local/share/applications/scalaide.desktop
mkdir -p ~/scalaide/configuration/.settings && cp $DOTFILES/scalaide/org.eclipse.ui.ide.prefs ~/scalaide/configuration/.settings/org.eclipse.ui.ide.prefs

# Install ADT bundle
curl -O http://dl.google.com/android/adt/adt-bundle-linux-x86_64.zip
unzip adt-bundle-linux-x86_64.zip && rm adt-bundle-linux-x86_64.zip
mv adt-bundle-linux-x86_64 ~/adt
cp $DOTFILES/adt/adt.xpm ~/adt/eclipse/icon.xpm
mkdir -p ~/.local/share/applications && cp $DOTFILES/adt/adt.desktop ~/.local/share/applications/adt.desktop
mkdir -p ~/adt/eclipse/configuration/.settings && cp $DOTFILES/adt/org.eclipse.ui.ide.prefs ~/adt/eclipse/configuration/.settings/org.eclipse.ui.ide.prefs

# Python
sudo easy_install pip
sudo pip install virtualenv virtualenvwrapper

# Node.js
sudo npm install -global coffee-script less jade ejs jasmine-node

# Ruby (part 1: rbenv and plugins)
curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
for rc in $DOTFILES/{irb,pry,gem}rc; do cp $rc ~/.${rc##*/}; done
PORTABLE_GEMS="bundler ruby-graphviz rake thor pry awesome_print mongoid guard execjs rails haml-rails coffee-rails twitter-bootstrap-rails rspec-rails factory_girl_rails fuubar database_cleaner jasminerice poltergeist"

# Ruby (part 2: CRuby)
sudo rbenv bootstrap-ubuntu-12-04
rbenv install 2.0.0-p0
rbenv global 2.0.0-p0
rbenv rehash
gem update --system
gem install $(echo $PORTABLE_GEMS pg sqlite3 therubyracer bson_ext yajl-ruby pry-debugger pry-stack_explorer ruby-prof)
gem update

# gVim
curl -Lo- https://bit.ly/janus-bootstrap | bash

# Ruby (part 3: JRuby)
rbenv install jruby-1.7.2
rbenv shell jruby-1.7.2
rbenv rehash
gem update --system
gem install $(echo $PORTABLE_GEMS therubyrhino jruby-openssl)
gem update

# oh-my-zsh
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | dash
git clone https://github.com/zsh-users/zsh-syntax-highlighting .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
chsh -s /bin/zsh
cp $DOTFILES/zshrc ~/.zshrc
cp $DOTFILES/zshenv ~/.zshenv
/bin/zsh
```
