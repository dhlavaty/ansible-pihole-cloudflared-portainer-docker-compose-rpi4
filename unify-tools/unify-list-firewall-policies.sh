#! /bin/sh

set -a # automatically export all variables
. ./.env # Most shells use `.` instead of `source`
set +a

# List Firewall Policies:
# https://developer.ui.com/network/v10.4.57/getfirewallpolicies

curl -Lgs "https://${UNIFY_HOST}/proxy/network/integration/v1/sites/${UNIFY_SITEID}/firewall/policies?offset=0&limit=100" \
     -H "Accept: application/json" \
     -H "X-API-Key: ${UNIFY_APIKEY}" \
     -k | jq
