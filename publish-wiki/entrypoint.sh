#!/bin/bash

set -euo pipefail

function configureGit {
    token=$1
    actor=$2

    if ! [[ -n "${SSH_KEY:-}" ]]; then
        (>&2 echo "ERROR. SSH_KEY is mandatory.")
        exit 1
    fi

    profile="$(curl -s -H "Authorization: token ${token}" "https://api.github.com/users/${actor}")"
    git config --global user.name "$(printf '%s' "${profile}" | jq -r .name)"
    git config --global user.email "$(printf '%s' "${profile}" | jq -r .email)"
}

function configureSsh {
    key=$1

    if ! [[ -n "${GITHUB_TOKEN:-}" ]]; then
        (>&2 echo "ERROR. GITHUB_TOKEN are mandatory.")
        exit 1
    fi

    echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >>/etc/ssh/ssh_known_hosts
    eval "$(ssh-agent -s)" >/dev/null
    mkfifo -m 600 ~/.ssh_key.fifo
    printf -- "${key}\n" >~/.ssh_key.fifo | ssh-add ~/.ssh_key.fifo
    rm ~/.ssh_key.fifo
}

function updateWiki {
    doc_path=$1
    wiki_repo_name=$2
    commit_message=$3

    echo "Wiki update starts..."
    wiki_repo="git@github.com:${wiki_repo_name}.wiki.git"

    echo "Uploading ${doc_path} content to ${wiki_repo}"
    git clone ${wiki_repo} wiki_folder_temp
    rm -rf wiki_folder_temp/*

    cp -rv ${doc_path} /* wiki_folder_temp
    cd wiki_folder_temp
    git commit -am ${commit_message}
    git push

    exit 0
}

configureSsh ${SSH_KEY}
configureGit ${GITHUB_TOKEN} ${GITHUB_ACTOR}

updateWiki $* ${GITHUB_REPOSITORY} "${GITHUB_ACTOR} - ${GITHUB_SHA}"
