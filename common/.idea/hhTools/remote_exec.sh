#!/usr/bin/env sh

cat .env $@ | ssh dev
