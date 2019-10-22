#!/usr/bin/env bash

. .env-common --source-only
. .env-local --source-only

cat > "$PROJECT_ROOT/$TRL_PATH/$BRANCH-trans.sql" <<EOF
/* Use \u00a0 as &nbsp; */
select insertTranslation('key', '');
EOF
