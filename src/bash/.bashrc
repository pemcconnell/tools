#!/bin/bash

# Set PATH
export PATH=$PATH:$HOME/.local/bin

# Aliases
source ~/.aliases
for alias in $(ls -1 ~/.aliases_*); do source "${alias}"; done

# Auto completion
if [ $(which kubectl) ]; then source <(kubectl completion bash); fi
complete -C terraform terraform
complete -C 'aws_completer' aws

# Export common environment variables
exenv ~/.env

# History
export HISTCONTROL=ignoreboth:erasedups  # for 'ignoreboth': ignore duplicates and /^\s/
export HISTIGNORE="&:ls:ll:la:l.:pwd:cd:exit:clear:c"
export HISTSIZE=1000000 # increase or decrease the size of the history to '1,000,000'
export HISTTIMEFORMAT='%H:%M > '
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S_%a  '  # makes history display in YYYY-MM-DD_HH:MM:SS_3CharWeekdaySpaceSpace format
shopt -s cmdhist                    # save multi-line commands in history as single line
shopt -s histappend histreedit histverify

# Some Go lang shtuff
export GOROOT=/usr/local/go
export GOPATH=$HOME/m/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export GOOS=linux

# Fix docker shtuff
if [ "${USER}" != root ]; then
    sudo chown ${USER} /var/run/docker.sock
fi

