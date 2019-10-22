#!/usr/bin/env sh

DEST_DIR="$HOME/Desktop"

build_idea_config() (
    cd tools && zip -qr "$DEST_DIR/tools.jar" -- * && \
    echo "Now import tools.jar via 'File > Import Settings' menu in IntelliJ IDEA"
)
