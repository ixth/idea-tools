#!/usr/bin/env sh

COMMON_SRC="common/"

copy_tools() {
    OVERRIDES_SRC="$1"
    PROJECT_FOLDER="$2"
    APP_MODULE_CHECK="$3"
    if [ -d "$OVERRIDES_SRC" ] && [ -e "$PROJECT_FOLDER/$APP_MODULE_CHECK" ]; then
        cp -v -pR "$COMMON_SRC" "$PROJECT_FOLDER"
        cp -v -pR "$OVERRIDES_SRC/" "$PROJECT_FOLDER"
    fi
}
