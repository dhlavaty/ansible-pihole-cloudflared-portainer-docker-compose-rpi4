#! /bin/sh

set -a # automatically export all variables
. ./.env # Most shells use `.` instead of `source`
set +a

curl -Lgs "https://${UNIFY_HOST}/proxy/network/integration/v1/sites?offset=0&limit=50" \
     -H "Accept: application/json" \
     -H "X-API-Key: ${UNIFY_APIKEY}" \
     -k | jq
