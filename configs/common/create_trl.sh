#!/usr/bin/env bash

. .env-common --source-only
. .env-local --source-only

TRL_FILE="$PROJECT_ROOT/$TRL_PATH/$BRANCH-trans.sql"
if [ ! -e "$TRL_FILE" ]; then
    cat > "$TRL_FILE" <<EOF
/* Use \u00a0 as &nbsp; */
select insertTranslation('key', '');
EOF
echo "$TRL_PATH/$BRANCH-trans.sql"
fi
