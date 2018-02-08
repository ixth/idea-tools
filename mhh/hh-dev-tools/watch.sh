#!/usr/bin/env bash

ssh dev <<DOC
cd codebase/hhmobile && \
yarn --non-interactive --force && \
yarn dev
DOC
