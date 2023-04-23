#! /usr/bin/env bash

# shellcheck disable=SC2034
DOCKER_UTILITY_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# shellcheck disable=SC1091
source "${DOCKER_UTILITY_DIR}/os.sh"

function get_now_time() {
    if [[ $(os.is_Linux) == true ]]; then
        # https://unix.stackexchange.com/questions/120484/what-is-a-standard-command-for-printing-a-date-in-rfc-3339-format
        NOW_TIME=$(date --rfc-3339=ns | sed 's/ /T/; s/\(\....\).*\([+-]\)/\1\2/g')
    else
        NOW_TIME="$(date)"
    fi

    echo "${NOW_TIME}"
}

function INFO() {
    if [[ "${LOG_DISABLE_COLOR}" == true ]]; then
        echo -e "[$(get_now_time)] [INFO] [${FUNCNAME[1]}]: $*"
    else
        echo -e "\033[0;32m[$(get_now_time)] [INFO] [${FUNCNAME[1]}]: $*\033[0m"
    fi
}

function ERROR() {
    if [[ "${LOG_DISABLE_COLOR}" == true ]]; then
        echo -e "[$(get_now_time)] [ERROR] [${FUNCNAME[1]}]: $*" >&2
    else
        echo -e "\033[0;31m[$(get_now_time)] [ERROR] [${FUNCNAME[1]}]: $*\033[0m" >&2
    fi
}
