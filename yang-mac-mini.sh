#!/bin/zsh

function tag-question() {
	cat "/Users/y62wang/Documents/Leetcode/tags.json" | jq ".topics | .[] | select(.name == \"$1\") | .questions" | sed "s/[ ,]//g" | egrep "\d." | sort
}

function company-question() {
	cat "/Users/y62wang/Documents/Leetcode/$1.txt" | awk {'print $1'} | sed "s/ ,/g/" | sort
}

function leetcode () {
	if [ "$#" -ne 2 ]; then
		echo "command format: question-filter [tag] [company]"
        return
	fi
	
	join <(tag-question $1) <(company-question $2) | qdata
}

function qdata() {
	while read line
	do
		printf "%-6s" $line
		cat "/Users/y62wang/Documents/Leetcode/questions.json" | jq ".stat_status_pairs | .[].stat | select (.question_id == $line) | .question__title"
	done < "${1:-/dev/stdin}"
}
