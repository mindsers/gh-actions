FROM debian:9.5-slim

LABEL "com.github.actions.name"="Publish to GitHub Wiki"
LABEL "com.github.actions.description"="Automatically publish a folder from your repo to its Wiki"
LABEL "com.github.actions.icon"="file-text"
LABEL "com.github.actions.color"="grey-dark"

LABEL "repository"="http://github.com/mindsers/gh-actions"
LABEL "homepage"="http://github.com/mindsers/gh-actions/publish-wiki"
LABEL "maintainer"="Mindsers <dev@nathanaelcherrier.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
