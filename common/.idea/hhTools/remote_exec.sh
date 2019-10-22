#!/usr/bin/env sh

cat .env-common .env-remote $@ | ssh dev
