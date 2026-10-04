#! /bin/sh

set -a # automatically export all variables
. ./.env # Most shells use `.` instead of `source`
set +a

# Get Wifi Broadcast Details:
# https://developer.ui.com/network/v10.4.57/getwifibroadcastdetails

curl -Lgs "https://${UNIFY_HOST}/proxy/network/integration/v1/sites/${UNIFY_SITEID}/wifi/broadcasts/${UNIFY_WIFIBROADCASTID}" \
     -H "Accept: application/json" \
     -H "X-API-Key: ${UNIFY_APIKEY}" \
     -k | jq
