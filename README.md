# My dot files #

Designed for my own use, but feel free to use and submit issues and suggestions. I would be glad to know that it helped anyone besides me.


## OS

Ubuntu 13.04 Raring Ringtail (x86_64)


## Setup

All commands below are meant to run on bash.

```bash
# Open bash
/usr/bin/env bash
```


### Install software

Add software sources to install software that are not from Canonical:

```bash
# Enable Canonical Partner
sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

# Add ppa's
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo add-apt-repository -y ppa:skype-wrapper/ppa

# Erlang/OTP ppa
wget -O - http://binaries.erlang-solutions.com/debian/erlang_solutions.asc | sudo apt-key add -
echo "deb http://binaries.erlang-solutions.com/debian quantal contrib" | sudo tee -a /etc/apt/sources.list.d/esl.list

# Heroku Toolbelt ppa
wget -O- https://toolbelt.heroku.com/apt/release.key | sudo apt-key add -
echo "deb http://toolbelt.heroku.com/ubuntu ./" | sudo tee /etc/apt/sources.list.d/heroku.list

# Opera ppa
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
echo "deb http://deb.opera.com/opera/ stable non-free" | sudo tee /etc/apt/sources.list.d/opera.list

# Google Talk Plugin ppa
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google.list
```

Install apt packages:

```bash
# Update package list
sudo apt-get update

# Install this package first, because it requires manual interaction
sudo apt-get install -y ttf-mscorefonts-installer

# Install packages
typeset -A pkgfor
pkgfor[app]="fbreader sublime-text vim-gtk racket kdiff3-qt meld guake pinta"
pkgfor[build]="build-essential checkinstall"
pkgfor[db]="mongodb libsqlite3-dev postgresql libpq-dev"
pkgfor[font]="fonts-inconsolata"
pkgfor[git]="git git-svn gitstats gitk"
pkgfor[media]="qbittorrent vlc audacious"
pkgfor[shell]="zsh ack-grep autojump xclip trash-cli curl imagemagick heroku-toolbelt"
pkgfor[stack]="python-setuptools nodejs rbenv openjdk-7-jdk esl-erlang"
pkgfor[ubuntu]="ubuntu-restricted-extras aptitude synaptic python-software-properties p7zip-full p7zip-rar"
pkgfor[x64]="ia32-libs"
pkgfor[web]="chromium-browser chromium-codecs-ffmpeg-extra opera djview-plugin google-talkplugin skype skype-wrapper"
sudo apt-get install -y ${pkgfor[app]} ${pkgfor[build]} ${pkgfor[db]} ${pkgfor[font]} ${pkgfor[git]} ${pkgfor[media]} ${pkgfor[shell]} ${pkgfor[stack]} ${pkgfor[ubuntu]} ${pkgfor[x64]} ${pkgfor[web]} graphviz exuberant-ctags libxslt-dev libxml2-dev libxml2-utils libqt4-dev libreadline-dev libfreetype6-dev

# Remove unwanted packages
sudo apt-get purge -y unity-lens-shopping ubuntuone-client* python-ubuntuone-* totem deja-dup rhythmbox transmission* thunderbird

# Perform full upgrade
sudo apt-get dist-upgrade -y

# Clean up
sudo apt-get autoremove --purge -y
sudo apt-get autoclean
```

Install [PhantomJS](http://phantomjs.org/) manually, since apt package is too old:

```bash
PHANTOMJS=phantomjs-1.9.0-linux-x86_64
curl http://phantomjs.googlecode.com/files/$PHANTOMJS.tar.bz2 | tar -xj
sudo mv $PHANTOMJS /usr/lib/phantomjs
sudo ln -s /usr/lib/phantomjs/bin/phantomjs /usr/bin/phantomjs
```

Install [Git-TF](https://gittf.codeplex.com/):

```bash
GITTF=git-tf-2.0.2.20130214
wget http://download.microsoft.com/download/A/E/2/AE23B059-5727-445B-91CC-15B7A078A7F4/$GITTF.zip
unzip $GITTF.zip && mv $GITTF git-tf && rm $GITTF.zip
sed -i 's/dirname "$0"/dirname "$(readlink -f $0)"/' git-tf/git-tf
sudo mv git-tf /usr/lib/
sudo ln -s /usr/lib/git-tf/git-tf /usr/bin/git-tf
```


### Configure development environment

Configure SSH key:

```bash
# Generate SSH key
ssh-keygen -t rsa -C "michelpm@gmail.com"

# Copy to clipboard
xclip -sel clip < ~/.ssh/id_rsa.pub
```

To upload to [Github](https://github.com/), go to [Account settings](https://github.com/settings/ssh), click 'Add SSH key', paste in the 'Key' text field and click in 'Add key'.

To upload the key to [Heroku](http://www.heroku.com/), use the [Heroku Toolbelt](https://toolbelt.herokuapp.com/):

```bash
# Login
heroku login

# Remove previous keys if you are not using them anymore, you may use also `keys:remove`
heroku keys:clear

# Upload
heroku keys:add
```

Configure workspace:

```bash
# The directory where you are going to clone the dotfiles repository
# This variable will be used in several steps from here on
DOTFILES=~/ws/etc/dotfiles

# Create empty folders on the workspace
mkdir -p ~/ws/{etc,st2,scala,adt,ruby,js}

# Clone this repository
git clone https://github.com/mmacedo/dotfiles $DOTFILES
```


### Configure programming stacks

Install [Elixir](http://elixir-lang.org/) and [expm](http://expm.co/):

```bash
# elixir
sudo git clone https://github.com/elixir-lang/elixir -b stable
pushd elixir && make test && popd

# expm
curl -O http://expm.co/__download__/expm && chmod +x expm
sudo mv expm bin/expm
```

Install [sbt](http://www.scala-sbt.org/):

```bash
curl http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt//0.12.3/sbt.tgz | tar -xz
```

Install [giter8](https://github.com/n8han/giter8) using [Conscript](https://github.com/n8han/conscript):

```bash
curl https://raw.github.com/n8han/conscript/master/setup.sh | bash
bin/cs n8han/giter8
```

Install [scala](http://www.scala-lang.org/):

```bash
SCALA=scala-2.10.1
curl http://www.scala-lang.org/downloads/distrib/files/$SCALA.tgz | tar -xz
mv $SCALA scala
```

Install [Play!](http://www.playframework.com/):

```bash
PLAY=play-2.1.1
curl http://downloads.typesafe.com/play/2.1.1/$PLAY.zip
unzip $PLAY.zip
mv $PLAY play
ln -s ~/play/play bin/play
```

Install [pip](http://www.pip-installer.org/) and [virtualenv](http://www.virtualenv.org/):

```bash
sudo easy_install pip
sudo pip install virtualenv virtualenvwrapper
```

Install global [NPM](http://nodejs.org/) ([Node.js](http://nodejs.org/)) packages for their binaries (they will not be in the path to require as a library):

```bash
sudo npm install -global coffee-script less jade ejs jasmine-node
```

Install several [rbenv](https://github.com/sstephenson/rbenv) plugins with [rbenv-installer](https://github.com/fesplugas/rbenv-installer) and the build the latest MRI/CRuby:

```bash
# Run rbenv-installer
curl https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash

# Run rbenv-bootstrap to install apt packages necessary to build Ruby on Ubuntu
sudo rbenv bootstrap-ubuntu-12-04

# Copy Ruby dotfiles
for rc in $DOTFILES/{irb,pry,gem}rc; do cp $rc ~/.${rc##*/}; done

# Load rbenv ruby to install gems
eval "$(rbenv init -)"

# List of gems to install
GEMS_FOR_BUNDLER="bundler ruby-graphviz"
GEMS_FOR_PRY="pry awesome_print pry-debugger pry-stack_explorer ruby-prof"
DATABASE_GEMS="mongoid pg sqlite3"
C_GEMS="therubyracer bson_ext yajl-ruby nokogiri"

# Install latest MRI
rbenv install 2.0.0-p0
rbenv global 2.0.0-p0

# Install gems
gem update --system
gem install $(echo rake thor $GEMS_FOR_BUNDLER $GEMS_FOR_PRY $DATABASE_GEMS $C_GEMS)
```


### Install and configure text editors and IDE's

Configure [Sublime Text 2](http://www.sublimetext.com/) and install [Sublime Package Control](http://wbond.net/sublime_packages/package_control) and [URL handler](http://blog.byscripts.info/2013/02/txmt-protocol-and-sublime-text-2-english.html). First time you open Sublime Text 2 after doing these steps, Sublime Text 2 will install Sublime Package Control. First time it opens after that, Sublime Package Control is going to read my list of packages and install every one of them, but it is going to generate several errors and may need a few restarts until it finishes. Also, do not forget to enter license.

```bash
ST2=~/.config/sublime-text-2

# Copy configuration
mkdir -p $ST2/Packages/User
cp $DOTFILES/st2/* $ST2/Packages/User

# Install package_control package
mkdir -p $ST2/Installed\ Packages
curl http://sublime.wbond.net/Package%20Control.sublime-package > $ST2/Installed\ Packages/Package\ Control.sublime-package

# Install url handler for txtm:// and subl:// with Sublime Text 2
wget https://raw.github.com/MrZYX/PKGBUILDs/master/sublime-url-handler/sublime-url-handler
chmod +x sublime-url-handler
sudo mv sublime-url-handler /usr/bin/
wget https://raw.github.com/MrZYX/PKGBUILDs/master/sublime-url-handler/sublime-url-handler.desktop
sudo mv sublime-url-handler.desktop /usr/share/applications/
sudo update-desktop-database
```

Install a [Vim](http://www.vim.org/) [distribution](https://github.com/carlhuda/janus) (need the ruby in the path to have rake installed). I don't pay much to attention to it, since I use it mainly to edit git commit messages.

```bash
curl -Lo- https://bit.ly/janus-bootstrap | bash
```

Install [Scala IDE](http://scala-ide.org/):

```bash
curl http://downloads.typesafe.com/scalaide-pack/3.0.0.vfinal-210-20130326/scala-SDK-3.0.0-vfinal-2.10-linux.gtk.x86_64.tar.gz | tar zx
mv eclipse ~/scalaide
convert ~/scalaide/icon.xpm -resize 48x48 ~/scalaide/icon.xpm
mkdir -p ~/.local/share/applications && cp $DOTFILES/scalaide/scalaide.desktop ~/.local/share/applications/scalaide.desktop
mkdir -p ~/scalaide/configuration/.settings && cp $DOTFILES/scalaide/org.eclipse.ui.ide.prefs ~/scalaide/configuration/.settings/org.eclipse.ui.ide.prefs
update-desktop-database
```

Install [ADT Bundle](https://developer.android.com/sdk/installing/bundle.html):

```bash
ADTBUNDLE=adt-bundle-linux-x86_64-20130219
curl -O http://dl.google.com/android/adt/$ADTBUNDLE.zip
unzip $ADTBUNDLE.zip && rm $ADTBUNDLE.zip
mv $ADTBUNDLE ~/adt
cp $DOTFILES/adt/adt.xpm ~/adt/eclipse/icon.xpm
mkdir -p ~/.local/share/applications && cp $DOTFILES/adt/adt.desktop ~/.local/share/applications/adt.desktop
mkdir -p ~/adt/eclipse/configuration/.settings && cp $DOTFILES/adt/org.eclipse.ui.ide.prefs ~/adt/eclipse/configuration/.settings/org.eclipse.ui.ide.prefs
update-desktop-database
```


### Configure command line tools

Configure default applications. It still doesn't set all that is necessary to make chromium the default web browser.

```bash
sudo update-alternatives --set x-www-browser /usr/bin/chromium-browser
sudo update-alternatives --set gnome-www-browser /usr/bin/chromium-browser
cp $DOTFILES/mimeapps.list ~/.local/share/applications
```

Configure [ack](http://betterthangrep.com/):

```bash
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
cp $DOTFILES/ackrc ~/.ackrc
```

Configure [git](http://git-scm.com/):

```bash
cp $DOTFILES/gitconfig ~/.gitconfig
```

Configure [zsh](http://www.zsh.org/) with [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh):

```bash
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
chsh -s /bin/zsh
cp $DOTFILES/zshrc ~/.zshrc
cp $DOTFILES/zshenv ~/.zshenv
```
