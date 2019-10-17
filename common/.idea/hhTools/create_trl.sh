#!/usr/bin/env bash

. .env --source-only
BRANCH=$(git rev-parse --abbrev-ref HEAD)
PROJECT_ROOT="$@"

cat > "$PROJECT_ROOT/$TRL_PATH/$BRANCH-trans.sql" <<EOF
/* Use \u00a0 as &nbsp; */
select insertTranslation('key', '');
EOF
