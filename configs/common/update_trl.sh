#!/usr/bin/env sh

. .env-common --source-only
. .env-local --source-only

ssh dev psql "$DATABASE_URL" < "$PROJECT_ROOT/$TRL_PATH/$BRANCH-trans.sql"
