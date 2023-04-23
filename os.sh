#! /usr/bin/env bash

function os.is_macOS() {
    if [[ $(uname) == "Darwin" ]]; then
        echo true
    else
        echo false
    fi
}

function os.is_Linux() {
    if [[ $(uname) == "Linux" ]]; then
        echo true
    else
        echo false
    fi
}
