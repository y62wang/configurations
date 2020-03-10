alias python python3


### GIT ALIASES
alias galias='alias | grep git'
alias amend='git commit --amend'
alias gdc='git diff --cached'
alias geffort='git log --pretty=format: --name-only | sort | uniq -c | sort -rg'
alias glarge='git ls-tree -l -r --full-name --abbrev HEAD | sort -n -k 4 -r'
