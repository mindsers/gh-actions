#!/bin/sh -l

set -eu

doc_path=$*
wiki_path="git@github.com:${GITHUB_REPOSITORY}/wiki.git"

git clone ${wiki_path}
rm -rf ${wiki_path}/.

cp -r ${doc_path}/* ${wiki_path}
cd ${wiki_path}
git commit -am "${GITHUB_ACTOR} - ${GITHUB_SHA}"
git push
