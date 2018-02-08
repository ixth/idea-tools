#!/usr/bin/env osascript -l JavaScript

function run(argv) {
    var app = Application.currentApplication();
    app.includeStandardAdditions = true;
    return app.chooseFolder({
        withPrompt: 'Choose folder for ' + argv[0]
    }).toString();
}