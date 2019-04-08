#!/bin/bash

set -euo pipefail

echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >>/etc/ssh/ssh_known_hosts

if [ "${SSH_KEY:-}" ] && [ "${SSH_KEY_VAR:-}" ] && [ "${GITHUB_TOKEN:-}" ]; then
    exit 2
fi

doc_path=$*
wiki_repo="git@github.com:${GITHUB_REPOSITORY}.wiki.git"

profile="$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/users/${GITHUB_ACTOR}")"
git config --global user.name "$(printf '%s' "$profile" | jq -r .name)"
git config --global user.email "$(printf '%s' "$profile" | jq -r .email)"

eval "$(ssh-agent -s)" >/dev/null
mkfifo -m 600 ~/.ssh_key.fifo
printf -- "${!SSH_KEY_VAR:-"$SSH_KEY"}\n" >~/.ssh_key.fifo | ssh-add ~/.ssh_key.fifo
rm ~/.ssh_key.fifo

git clone ${wiki_repo} wiki_folder_temp
rm -rf wiki_folder_temp/*

cp -rv ${doc_path}/* wiki_folder_temp
cd wiki_folder_temp
git commit -am "${GITHUB_ACTOR} - ${GITHUB_SHA}"
git push
