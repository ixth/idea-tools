#!/usr/bin/env bash

ssh dev <<DOC
cd codebase/hh.sites.main && \
yarn --non-interactive --force && \
yarn build-watch -s
DOC
