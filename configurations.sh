#!/bin/zsh

if [ -z "$YANG_CFG_DIR" ]; then
    export YANG_CFG_DIR="/tmp/configurations"
    echo "default configuration directory not found, using $YANG_CFG_DIR";
fi

export PATH="$PATH:$YANG_CFG_DIR"

# common scripts that I would use daily
source common.sh
source gradle.sh
source tools.sh
source chess.sh

### COMMON CONFIGURATIONS
EDITOR=vi
VISUAL=vim


# enable vi mode for command line input
set -o vi
bindkey -v

export GREP_OPTIONS='--color=always'
source overrides.sh
