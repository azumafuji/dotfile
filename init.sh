#!/bin/bash

java -version

sudo /usr/libexec/locate.updatedb

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

#brew tap marcqualie/nginx
#brew tap phinze/homebrew-cask

brew install caskroom/cask/brew-cask

brew cask install caffeine
#brew cask install cord
brew cask install firefox
brew cask install google-chrome
brew cask install itunes-volume-control
brew cask install jumpcut
#brew cask install light-table
brew cask install screenhero
#brew cask install sourcetree
brew cask install vagrant
brew cask install spectacle
brew cask install bittorrent-sync
brew cask install flux
brew cask install pandoc
brew cask install hermes

brew install rbenv
brew install emacs --cocoa --with-gnutls --HEAD --use-git-head -srgb
brew install git
# This needs java!
brew install graphviz --with-app --with-bindings --with-freetype
#brew install hub
#brew install leiningen
#brew install memcached
#brew install libmemcached
#brew install nginx-full --with-spdy --with-lua-module --with-webdav
#brew install postgresql 
#brew install pypy
#brew install rabbitmq
#brew install redis
#brew install rethinkdb
brew install source-highlight
brew install the_silver_searcher
brew install zeromq

sudo cp ~/src/dotfiles/paths /etc/paths

mkdir ~/src/pypicache
mkdir ~/.ec2

mkdir ~/.git

ln -s ~/src/dotfiles/gitconfig ~/.gitconfig
ln -s ~/src/dotfiles/gitignore_global ~/.gitignore_global

git clone git@github.com:milkbikis/powerline-shell.git ~/src/powerline-shell
cd  ~/src/powerline-shell
./install.py
cd
ln -s ~/src/powerline-shell/powerline-shell.py ~/.powerline-shell.py

mkdir ~/.lein
ln -s ~/src/dotfiles/profiles.clj ~/.lein/profiles.clj

ln -s ~/src/dotfiles/source-highlight ~/.source-highlight

mkdir ~/Documents/iPython

mkdir ~/Documents/org
mkdir -p ~/.emacs.d/snippets
ln -s ~/src/dotfiles/lisp ~/.emacs.d/lisp
ln -s ~/src/dotfiles/emacs ~/.emacs


cd /tmp
curl -O https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
sudo python ez_setup.py

sudo easy_install pip 
sudo pip install virtualenv virtualenvwrapper
sudo pip install rope ropemacs
sudo pip install pyzmq
sudo pip install readline ipython
sudo pip install proxypypi
sudo pip install jinja2 tornado

git clone git://github.com/pinard/Pymacs.git ~/src/Pymacs
cd ~/src/Pymacs
make
sudo python setup.py install

ipython profile create
rm ~/.ipython/profile_default/ipython_config.py
rm ~/.ipython/profile_default/ipython_notebook_config.py
ln -s ~/src/dotfiles/ipython_config.py ~/.ipython/profile_default/ipython_config.py
ln -s ~/src/dotfiles/ipython_notebook_config.py ~/.ipython/profile_default/ipython_notebook_config.py

mkdir ~/.pip
ln -s ~/src/dotfiles/pip.conf ~/.pip/pip.conf
ln -s ~/src/dotfiles/pydistutils.cfg ~/.pydistutils.cfg

ln -s ~/src/dotfiles/bashrc ~/.bashrc
ln -s ~/src/dotfiles/profile ~/.profile
ln -s ~/src/dotfiles/bash_profile ~/.bash_profile

git clone git://github.com/chriskempson/tomorrow-theme.git ~/src/tomorrow-theme

#git clone git://github.com/azumafuji/editmoin.git ~/src/editmoin

#sh ~/src/dotfiles/osx.sh

