alias gbd='gradle debugger'

# @temp
function sort_file() {
	cat $1 | sort > /tmp/tmp.txt
	cat /tmp/tmp.txt > $1
}

# @temp
function sort_and_diff() {
	sort_file $1;
	sort_file $2;
	diff $1 $2;
}

# @temp
function qperft_comp() {
    depth=$1
    divide=$(( $1 - 1 ))
    fen=$2
    echo $depth $divide $fen
    ./qperft $depth -$divide $fen | grep " = " | awk '{print $2, $5}' | sort > left.txt
    java -jar build/libs/vegapunk-debugger-1.0-SNAPSHOT.jar $fen $depth | sort > right.txt
    diff left.txt right.txt
}

# @temp
function yp() {
    depth=$1
    fen=$2
    runs=$3
    echo $depth $fen
    java -jar build/libs/vegapunk-debugger-1.0-SNAPSHOT.jar $fen $depth $runs | tee right.txt
}
