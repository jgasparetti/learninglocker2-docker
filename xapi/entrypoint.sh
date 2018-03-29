#!/bin/bash
set -e

# substitute env variables in configuration
envsubst < /usr/src/app/.env.template > /usr/src/app/.env

exec "$@"

