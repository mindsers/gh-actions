FROM debian:9.5-slim

LABEL "com.github.actions.name"="Publish to GitHub Wiki"
LABEL "com.github.actions.description"="Automatically publish a folder from your repo to its Wiki"
LABEL "com.github.actions.icon"="file-text"
LABEL "com.github.actions.color"="grey-dark"

LABEL "repository"="https://github.com/mindsers/gh-actions"
LABEL "homepage"="https://github.com/mindsers/gh-actions/publish-wiki"
LABEL "maintainer"="Nathanaël CHERRIER <dev@nathanaelcherrier.com>"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        bash \
        curl \
        jq \
        git \
        openssh-client && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
