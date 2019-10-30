#!/usr/bin/env sh

psql "$DATABASE_URL" < "$CODEBASE_PATH/$TRL_PATH/$BRANCH-trans.sql"
if nc -z 127.0.0.1 "$HH_TRANSLATIONS_PORT"; then
    /opt/deploy-dev/utils/hhc.py hh-translations deploy
fi
