source common_aliases.sh

autoload -U colors
colors
setopt AUTO_PUSHD
setopt PUSHD_MINUS
setopt CDABLE_VARS

setopt EXTENDED_HISTORY        # store time in history
setopt HIST_EXPIRE_DUPS_FIRST  # unique events are more usefull to me
setopt HIST_VERIFY             # Make those history commands nice
setopt INC_APPEND_HISTORY      # immediatly insert history into history file
HISTSIZE=160000                # spots for duplicates/uniques
SAVEHIST=150000                # unique events guaranteed
HISTFILE=~/.history


# ********************************************* KEY BINDING *********************************************

if [[ $TERM == "xterm-256color" ]]; then
  #Mac OSX/BSD bindings for Home/End/Del
  bindkey "^[[H" beginning-of-line
  bindkey "^[[F" end-of-line
  bindkey "^[[3~" delete-char
fi


# ********************************************* CONFIG RELATED ***********************************************

# reloads the configurations 
function rl() {
    source "$YANG_CFG_DIR/configurations.sh" && echo "Script '$YANG_CFG_DIR/configurations.sh' is reloaded".;
}

# reload and sync functionality
function rl!() {
    cd $YANG_CFG_DIR
    git stash
    git pull --rebase
    git stash apply
    rl
    cd -
}

# ********************************************* COMMON FUNCTIONS *********************************************

# open all files in a single sublime text window
function sub() {
    subl -a $1
}


function vf() {
    e $(fzf)
}
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
function vo() (
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vi} "${files[@]}"
)

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
function fo() (
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vi} "$file"
  fi
)

# fd - cd to selected directory
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# go up directory N times
function up() {
    times=1
    if [[ -n "$1" ]] then
        times=$1
    fi

    for (( i=0 ; i < $times ; i++ ))
    do
      cd ..
    done

    return;
}

# cdf - cd into the directory of the selected file
function cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}


function def() {
    function_name=$1
    declare -f $function_name;
}

# fkill - kill process
function fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

function grep-kill() {
    ps aux | grep "$1" | awk '{print $2}' | xargs kill -9
}

function install-tools-mac() {
    brew update;
    brew install python;
    brew install git;
    brew install macvim;
    brew install ag;
    brew install pick;
    brew install tree;
    brew install gradle;
    brew install maven;
    brew install colordiff;
    brew install tig;
    brew install jq jp fx;
    brew install bitwise;
    brew install bat bmon htop nmap;
    brew install dark-mode ack midnight-commander htop wget geoip watch awscli calc jq lftp links lynx ncdu nmap tmux tree unrar vimpager;
    brew install cask;
    brew cask install firefox;
    brew cask install kdiff3;
    brew cask install diffmerge;
    brew cask install visualvm;
}

function initialize-git-defaults() {
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global color.ui true
    git config --global color.diff-highlight.oldNormal    "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal    "green bold"
    git config --global color.diff-highlight.newHighlight "green bold 22"

    git config --global color.diff.meta       "yellow"
    git config --global color.diff.frag       "magenta bold"
    git config --global color.diff.commit     "yellow bold"
    git config --global color.diff.old        "red bold"
    git config --global color.diff.new        "green bold"
    git config --global color.diff.whitespace "red reverse"
}

function cheatsheet() {
    echo '########################################################################################################';
    echo '# 1.  Download Configurations:                 git clone https://github.com/y62wang/configurations.git #';
    echo '# 2.  Install && Source:                                                       add script here         #';
    echo '# 2.  Install && Source ON HOST:                                               add script here         #';
    echo '########################################################################################################';
}

