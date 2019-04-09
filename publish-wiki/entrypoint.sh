#!/bin/bash

set -euo pipefail

function configureGit {
    token=$1
    actor=$2

    if ! [[ -n "${token:-}" ]]; then
        (>&2 echo "ERROR. GITHUB_TOKEN is mandatory.")
        exit 1
    fi

    profile="$(curl -s -H "Authorization: token ${token}" "https://api.github.com/users/${actor}")"
    git config --global user.name "$(printf '%s' "${profile}" | jq -r .name)"
    git config --global user.email "$(printf '%s' "${profile}" | jq -r .email)"
}

function updateWiki {
    doc_path=$1
    wiki_repo_name=$2
    commit_message=$3

    echo "Wiki update starts..."
    wiki_repo="https://${GITHUB_TOKEN}@github.com:${wiki_repo_name}.wiki.git"

    echo "Uploading ${doc_path} content to ${wiki_repo}"
    git clone ${wiki_repo} wiki_folder_temp
    rm -rf wiki_folder_temp/*

    cp -rv ${doc_path} /* wiki_folder_temp
    cd wiki_folder_temp
    git commit -am ${commit_message}
    git push

    exit 0
}

configureGit ${GITHUB_TOKEN} ${GITHUB_ACTOR}
updateWiki $* ${GITHUB_REPOSITORY} "${GITHUB_ACTOR} - ${GITHUB_SHA}"
