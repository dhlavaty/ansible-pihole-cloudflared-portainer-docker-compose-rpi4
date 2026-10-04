#! /bin/sh

set -a # automatically export all variables
. ./.env # Most shells use `.` instead of `source`
set +a

# List Wifi Broadcasts:
# https://developer.ui.com/network/v10.4.57/getwifibroadcastpage

curl -Lgs "https://${UNIFY_HOST}/proxy/network/integration/v1/sites/${UNIFY_SITEID}/wifi/broadcasts" \
     -H "Accept: application/json" \
     -H "X-API-Key: ${UNIFY_APIKEY}" \
     -k | jq
