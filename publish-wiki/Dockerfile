FROM debian:9.5-slim

LABEL "com.github.actions.name"="Publish GitHub Wiki"
LABEL "com.github.actions.description"="Automatically publish a folder from your repo to its Wiki"
LABEL "com.github.actions.icon"="book"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/mindsers/publish-wiki"
LABEL "homepage"="http://github.com/mindsers/publish-wiki"
LABEL "maintainer"="Mindsers <dev@nathanaelcherrier.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
