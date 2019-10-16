#!/usr/bin/env sh

build_idea_config() {
    (cd tools && \
    zip -qr ../tools.jar -- * && \
    echo "Now import tools.jar via 'File > Import Settings' menu in IntelliJ IDEA")
}
