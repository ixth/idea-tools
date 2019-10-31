#!/usr/bin/env sh

build_idea_config() (
    DEST_DIR="$HOME/Desktop"
    cd tools && zip -qr "$DEST_DIR/tools.jar" -- * && \
    echo "Now import tools.jar via 'File > Import Settings' menu in IntelliJ IDEA"
)
