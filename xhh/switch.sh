#!/usr/bin/env bash

ssh dev 'cd /opt/deploy-dev/utils && ./hhc.py hh.sites.main ' $1
