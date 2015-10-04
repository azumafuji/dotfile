#!/bin/bash
# -*- mode: sh-mode -*-
export EDITOR=emacs
export TERM=xterm-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1 
export LESSOPEN="| ~/.source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R "
export SOURCE_HIGHLIGHT_DATADIR=~/.source-highlight/
export JAVA_HOME=$(/usr/libexec/java_home)
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
export PROXY_PYPI_DIR="$HOME/src/pypicache"

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export DOCKER_HOST="tcp://192.168.252.50:2375"

ulimit -n 4096 

export DJANGO_COLORS="light"

alias rcp='rsync -aP'
alias cleanpyc='find . -name '*.pyc' -exec rm {} \;'

alias serveit='python -m SimpleHTTPServer 8080'
alias timestamp='date "+%Y%m%dT%H%M%S"'
alias ppp='proxypypi -p 8333 -d $PROXY_PYPI_DIR -P $PROXY_PYPI_DIR/proxypypi.pid -l $PROXY_PYPI_DIR/proxypypi.log -o $PROXY_PYPI_DIR/proxypypi.console'
alias updaterepos='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;'


if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -f ./src/liquidprompt/liquidprompt ]; then
    source src/liquidprompt/liquidprompt
fi

if [ -f .local.env ]; then
  source .local.env
fi

# Run twolfson/sexy-bash-prompt
if [ -f .bash_prompt ]; then
  source .bash_prompt
fi

# Configure bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Configure NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
