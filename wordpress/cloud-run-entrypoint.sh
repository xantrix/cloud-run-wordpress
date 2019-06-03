#!/bin/bash
set -ex

# Start the sql proxy
cloud_sql_proxy -instances=$CLOUDSQL_INSTANCE=tcp:3306 &

# Start the original entrypoint
docker-entrypoint.sh "$@"