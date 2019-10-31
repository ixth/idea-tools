#!/usr/bin/env sh

copy_tools() {
    COMMON_DIR="configs/common"
    OVERRIDES_DIR="configs/$1"
    PROJECT_FOLDER="$2"
    DEST_DIR="$PROJECT_FOLDER/.idea/hhTools"
    APP_MODULE_CHECK="$3"
    if [ -d "$OVERRIDES_DIR" ] && [ -e "$PROJECT_FOLDER/$APP_MODULE_CHECK" ]; then
        [ -d "$DEST_DIR" ] || mkdir -p "$DEST_DIR"
        cp -v -pR "$COMMON_DIR/" "$OVERRIDES_DIR/" "$DEST_DIR/"
    fi
}
