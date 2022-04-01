# configuration customized for different 

# mac configuration
#source zsh-config.sh 
alias kubectl="minikube kubectl --"
function mwcookie {
    echo "$(cat ${HOME}/.envimprovement/kcurl.cookies | grep -v 'midway-auth.amazon.com')" > ${HOME}/.envimprovement/kcurl.cookies
    cat ~/.midway/cookie | grep -zoP "^\n(.*\n)+" | head -n -1 | tac | head -n -1 | tac >> ${HOME}/.envimprovement/kcurl.cookies
}
