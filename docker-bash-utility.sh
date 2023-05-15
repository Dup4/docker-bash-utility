#! /usr/bin/env bash

DOCKER_BASH_UTILITY_CUR_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# shellcheck disable=SC1091
source "${DOCKER_BASH_UTILITY_CUR_DIR}/os.sh"
# shellcheck disable=SC1091
source "${DOCKER_BASH_UTILITY_CUR_DIR}/log.sh"
# shellcheck disable=SC1091
source "${DOCKER_BASH_UTILITY_CUR_DIR}/docker_utility.sh"
