#!/bin/zsh

export YANG_CFG_DIR='/Users/y62wang/workplace/configurations'
export PATH="$PATH:$YANG_CFG_DIR"

# common scripts that I would use daily
source common.sh
source gradle.sh

# configuration customized for different 
source yang-mac-mini.sh