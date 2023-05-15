#! /usr/bin/env bash

# shellcheck disable=SC2034
DOCKER_UTILITY_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# shellcheck disable=SC1091
source "${DOCKER_UTILITY_DIR}/logger.sh"

function docker_utility.get_container_id_by_name() {
    local old_container_id
    old_container_id="$(docker ps -q -f "name=${1}")"
    echo "${old_container_id}"
}

function docker_utility.has_container_exists_by_name() {
    local id
    id="$(get_container_id_by_name "${1}")"

    if [[ -n "${id}" ]]; then
        echo true
        return
    fi

    echo false
}

function docker_utility.clean_old_container_by_name() {
    local container_name
    local old_container_id

    container_name="${1}"
    old_container_id="$(get_container_id_by_name "${container_name}")"

    if [[ -n "${old_container_id}" ]]; then
        docker stop "${old_container_id}"
        docker rm "${old_container_id}"

        log.INFO "finish stop and rm container. [name=${container_name}]"
    fi
}
