#!/bin/zsh
if ! klist -s; then kinit -f -l 3600h; fi

if [[ $TERM == "xterm-256color" ]]; then
  #Mac OSX/BSD bindings for Home/End/Del
  bindkey "^[[H" beginning-of-line
  bindkey "^[[F" end-of-line
  bindkey "^[[3~" delete-char
fi

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

################################### CONFIGURATIONS ###################################
export PATH="/apollo/env/SDETools/bin:$PATH"
export BRAZIL_PLATFORM_OVERRIDE="RHEL5_64"

################################### ALIASES ###################################

# Remote Machines
alias ki="kinit -f"
alias ssh1="ssh -o ProxyCommand=None $1"

VM2="dev-dsk-yanwany-2a3-i-fbe3f90d.us-west-2.amazon.com"
VM3="dev-dsk-yanwany-2a-f076c40e.us-west-2.amazon.com"
alias vm2="ssh $VM2"
alias vm3="ssh $VM3"

# GIT ALIASES
alias last-commit="git log --stat --max-count=1 --decorate --graph"
alias script="sub ~/workplace/scripts/zsh-config.sh"


function w() {
  open "http://w?`echo $@`" &;
}

######################################## OTHER ########################################
unitTestFile="build/brazil-unit-tests/index.html";
coverageFile="build/brazil-documentation/coverage/index.html";
checkStyleFile="build/brazil-documentation/checkstyle/checkstyle_report.html"
integTestFile="build/brazil-integ-tests/index.html"
findBugsFile="build/brazil-documentation/findbugs/findbugs_report.html"

function envlog() {
  cd /apollo/env/
  cd $1
  cd var/output/logs
}

######################################## BRAZIL ########################################
alias bws="brazil-recursive-cmd --allPackages brazil-build"
alias b="brazil-build build"
alias dry-run="brazil ws dryrun"
alias bba="brazil-build;artifacts";
alias clean-build="brazil-build clean && brazil-build"
alias cb="bb clean && bb"
alias dryrun="brazil ws dryrun"

alias syncmd="brazil ws --sync --md"
alias sync="brazil ws sync"
alias checkout="brazil ws --use --package $1"
alias create-ws="brazil ws --create --name $1"
alias vs="brazil ws --use --versionset $1"

function clean-build-ws() {
    brazil ws clean
    bws build
}

######################################################
############### BRAZIL-BUILD SCRIPTS #################
######################################################

function remove-package() {
    if [ ! -d $1 ]; then
        echo "Cannot remove package '$1', the folder does not exist!"
        return
    fi

    cd $1
    git reset --hard
    git clean -d -f -x
    cd ..
    brazil ws remove --package $1
}

function bbx() {
    brazil-build 2>&1 | tee output.txt
}

function b() {
    brazil-build build
}

function bb()
{
    if [ "$#"  -eq 1 ]; then
        brazil-build "$1"
    else
        bbx
        OUT=$?
        line=`tail output.txt -n 5`
        if [[ $line == *"BUILD FAILED"* ]]; then
            echo "\n\nFinding artifacts related to the build failure ..."
            show-failed-tests
            artifacts
        fi
    fi
}

function openIfExists() {
    local flag=0
    if [ -e $1 ]; then
        echo "Opening file: '$1'"
        open $1 &> /dev/null &
    else
        flag=1
    fi
    return $flag
}

# open build artifacts
function artifacts() {

    #findbugs
    grep -Eo "FindBugsSummary.*? total_bugs=\"0\"" build/brazil-documentation/findbugs/findbugs_report.xml &> /dev/null
    findBugsProblem=$?

    if [ -e $findBugsFile ] && [ $findBugsProblem -ne 0 ]; then
        openIfExists $findBugsFile
        return
    fi

    # checkstyle
    grep -Eo "<th>Total errors</th><td>0</td>" build/brazil-documentation/checkstyle/checkstyle_report.html &> /dev/null
    checkStyleProblem=$?

    if [ -e $checkStyleFile ] && [ $checkStyleProblem -ne 0 ]; then
        openIfExists $checkStyleFile
        return
    fi

    # coverage and tests
    openIfExists $coverageFile
    coverageProblem=$?
    if [[ $coverageProblem -ne 0 ]]; then
        openIfExists $integTestFile
        openIfExists $unitTestFile
    fi
}

######################################## HOSTS ########################################
######################################## G2S2 ########################################
alias ionpp="/apollo/env/G2S2CommandTools/bin/ion-formatter --format pretty"

#alias g2s2rd="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-repo.integ.amazon.com/"
#alias g2s2="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-repo-author.integ.amazon.com/"

# no-rush promo g2s2 alias
alias g2s2rd="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-cache-na-sea.amazon.com/"
#alias g2s2rd="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-query-na.amazon.com/"
#alias g2s2="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-repo-author.integ.amazon.com/"

alias g2s2="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-author.amazon.com/"
#alias g2s2rd="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-repo-author-na.amazon.com/"
#alias g2s2="/apollo/env/G2S2CommandTools/bin/g2s2 -u http://g2s2-repo-author-na.amazon.com/"

######################################## NO-RUSH ########################################

alias envs='ls /apollo/env | xargs -n 1 echo setenv'
alias lsenv='/bin/ps axwww | grep -o -P "/apollo/env/[a-zA-Z0-9\\-]+" | sort | uniq | cut -d "/" -f4- | xargs -n 1 echo setenv '
alias pwe='echo ${CURRENT_WORKING_ENV}'
alias cdl='cd /apollo/env/${CURRENT_WORKING_ENV}/var/output/logs'
alias cdr='cd /apollo/env/${CURRENT_WORKING_ENV}'
alias fact='pact && act'
alias bae='brazil ws --attachenvironment --alias '
alias bde='brazil ws --detachenvironment --alias '
alias aman='less /apollo/env/${CURRENT_WORKING_ENV}/Apollo/Manifest'

setenv() {
    export CURRENT_WORKING_ENV=$1
    export PROMPT_ENV=$1
    evalPrompt
}

# activate a particular environment
act() {
    envOp Activate $1
 }

getApolloEnv() {
    if [[ -n $1 ]]; then
        export env=$1
    elif [[ -n ${CURRENT_WORKING_ENV} ]]; then
        export env=$CURRENT_WORKING_ENV
    else
        echo "No environment set or specificed."
        return
    fi
    export getApolloEnvResult=${env}
}

envOp() {
    getApolloEnv $2
    apolloRunCommand $1 $getApolloEnvResult
}


apolloRunCommand() {
    sudo /apollo/bin/runCommand -a $1 -e $2
}

# clean activate
#    ps | grep -i processmanager | grep ${CURRENT_WORKING_ENV} | grep -v ApolloCmd  | cut -d" " -f3 | xargs -n1 sudo kill -9
#    ps | grep -i processmanager | grep ${CURRENT_WORKING_ENV} | grep -v ApolloCmd  | cut -d" " -f2 | xargs -n1 sudo kill -9
#    ps | grep ${CURRENT_WORKING_ENV} | awk "{print $2}" | xargs -n1 kill -9
cact() {
    dact
    sudo rm /apollo/env/${CURRENT_WORKING_ENV}/var/output/logs/*
    act
    echo "SETLOGLEVEL ||Debug ."| nc localhost 10010
}

# deactivate a particular environment
dact() {
    envOp Deactivate $1
}

pact() {
    envOp Preactivate $1
}

ract() {
    dact $1
    sleep 5
    act $1
}

alias dact_all='lsenv | xargs -n 1 sudo /apollo/bin/runCommand -a Deactivate -e '

function nuke-env() {
    if [ "$#"  -eq 1 ]; then
        ENV=$1
        sudo rm -f /apollo/env/$ENV
        sudo rm -f /apollo/env/$ENV*
        sudo rm -rf /apollo/_env/$ENV
        sudo rm -rf /apollo/_env/$ENV*
        sudo rm -rf /apollo/var/env/$ENV
        sudo rm -rf /apollo/var/env/$ENV*
        sudo rm -rf
        /apollo/package/local_1/Generic/$ENV*
    else
        return
    fi
}

# change status to stay down
asd () {
    apolloHostControl --status StayDown $1
}

asa () {
    apolloHostControl --ignore-failures --status Active $1
}

#--------------------------------
# brazil related aliases

# brazil workspace
alias bw='brazil ws'

# brazil add package
bap() {
    bw --use --package $1 --branch mainline
}

bapo() {
    bw --use --package $1 --branch mainline
}

# brazil add package from a branch
bapb() {bw --use --package $1 --branch $2 }

# brazil remove package
brp() {bw --remove --package $1 }

# brazil create workspace
bcw() {
    mkdir $1
    bw --create --name $1 --root $1
}

# brazil create workspace for a versionset
bcwv() {
    mkdir $1
    bw --create --name $1 --root $1 --versionset $2
}

bdw() {
    bw --delete --force --root $1
    rm -r $1
}

bdp() {
    brazil pkg --delete -r "removing package" -p $1
}



git-pull-all-pkgs() {
    # store the current dir
    CUR_DIR=$(pwd)

    # Let the person running the script know what's going on.
    echo "\n\033[1mPulling in latest changes for all repositories...\033[0m\n"

    # Find all git repositories and update it to the master latest revision
    for i in $(find . -name ".git" | cut -c 3-); do
        echo "";
        echo "\033[33m"+$i+"\033[0m";

        # We have to go to the .git parent directory to call the pull command
        cd "$i";
        cd ..;

        # finally pull
        git pull --rebase;

        # lets get back to the CUR_DIR
        cd $CUR_DIR
    done

    echo "\n\033[32mComplete!\033[0m\n"
}

append-script() {
    echo $1"\n" >> /Users/yanwany/workplace/scripts/zsh-config.sh
}

show-failed-tests() {
    cat output.txt | egrep "TEST (.*) FAILED" | sed -E "s/(.*) TEST (.*) FAILED/\2/"
}

single-test() {
    bb single-test -DtestClass=$1
}

run-failed-tests() {
    while :
    do
        for line in `show-failed-tests`; do
            single-test $line
        done
        sleep 30
    done
}

####################################################################################
## modify gi

function ee() {
    myfile="$(gst | grep ":   " | pick | awk '{print $2}')"
    echo $myfile
    if [[ -n "${myfile}" ]]; then
        sub $myfile
    fi
}

function repo() {
    wd repo
    git clone ssh://git.amazon.com/pkg/$1
}
