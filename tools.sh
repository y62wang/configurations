function ports() {
    sudo lsof -PiTCP -sTCP:LISTEN
}

function ports-listening() {
    sudo lsof -PiTCP -sTCP:LISTEN
}

function hosts_connected_on_port() { 

}

function tail_log_from_multiple_hosts() {
    list_of_hosts=$1
}

function remote_download_files() {
}

function remote_upload_files() {
}
