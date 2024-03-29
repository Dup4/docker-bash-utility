#! /usr/bin/env bash

# shellcheck disable=SC2034
DOCKER_UTILITY_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# shellcheck disable=SC1091
source "${DOCKER_UTILITY_DIR}/log.sh"

function docker_utility.get_container_id_by_name() {
    local old_container_id
    old_container_id="$(docker ps -q -f "name=^${1}$")"
    echo "${old_container_id}"
}

function docker_utility.has_container_exists_by_name() {
    local id
    id="$(docker_utility.get_container_id_by_name "${1}")"

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
    old_container_id="$(docker_utility.get_container_id_by_name "${container_name}")"

    if [[ -n "${old_container_id}" ]]; then
        log.info "find old container. [name=${container_name}] [id=${old_container_id}]"

        docker stop "${old_container_id}"
        docker rm "${old_container_id}"

        log.info "finish stop and rm container. [name=${container_name}] [id=${old_container_id}]"
    else
        log.info "can't find old container. [name=${container_name}]"
    fi
}

function docker_utility.pull_image() {
    local image_name
    image_name="${1}"

    if [[ -z "${image_name}" ]]; then
        log.fatal "usage: docker_utility.pre_pull_image [image_name]"
        return
    fi

    if [[ -z "$(docker images -q "${image_name}")" ]]; then
        log.info "can't find image. [name=${image_name}]"
    else
        log.info "find image. [name=${image_name}]"
        return
    fi

    log.info "start pull image. [name=${image_name}]"
    docker pull "${image_name}"
    log.info "finish pull image. [name=${image_name}]"
}
