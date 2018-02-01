#!/usr/bin/env bash

ssh dev 'cd /opt/deploy-dev/utils && ./hhc.py hhmobile ' $1
