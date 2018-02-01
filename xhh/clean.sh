#!/usr/bin/env bash

ssh dev <<DOC
cd codebase/hh.sites.main && \
git fetch && \
git clean -dfx && \
git co -f master && \
git reset --hard origin/master && \
echo -n '\n\n' && \
git log -n 1
DOC
