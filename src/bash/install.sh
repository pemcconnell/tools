#!/usr/bin/env bash

set +x

SCRIPT_PATH="`dirname \"$0\"`"                  # relative
SCRIPT_PATH="`( cd \"$SCRIPT_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "${SCRIPT_PATH}" ] ; then
  echo "ERROR! For some reason, the path is not accessible to the script (e.g. permissions re-evaled after suid)"
  exit 1
fi

# Backup original files
if [ -f ~/.aliases ]; then mv ~/.aliases ~/.aliases.$(date +%Y%m%d-%H%M); fi
if [ -f ~/.bashrc ]; then mv ~/.bashrc ~/.bashrc.$(date +%Y%m%d-%H%M); fi
if [ -f ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.$(date +%Y%m%d-%H%M); fi

# Hard link files
# This will work only if the source and destination files are on the same partition!
ln ${SCRIPT_PATH}/.aliases ~/.aliases
ln ${SCRIPT_PATH}/.bashrc ~/.bashrc
ln ${SCRIPT_PATH}/.vimrc ~/.vimrc
