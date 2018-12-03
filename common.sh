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


# ********************************************* COMMON FUNCTIONS *********************************************

# open all files in a single sublime text window
function sub() {
    subl -a $1
}

function reload() {
    source "$YANG_CFG_DIR/configurations.sh";
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

function install-tools-mac() {
    brew update;
    brew install python;
    brew install git;
    brew install macvim;
    brew install ag;
    brew install tree;
    brew install gradle;
    brew install maven;
    brew install colordiff;
    brew install tig;
    brew install dark-mode ack midnight-commander htop wget geoip watch awscli calc jq lftp links lynx ncdu nmap tmux tree unrar vimpager;
    brew install cask;
    brew cask install kdiff3;
    brew cask install diffmerge;
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