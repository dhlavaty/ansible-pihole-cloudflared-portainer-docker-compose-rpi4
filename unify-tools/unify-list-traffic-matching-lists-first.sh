#! /bin/sh

set -a # automatically export all variables
. ./.env # Most shells use `.` instead of `source`
set +a

# List Traffic Matching Lists:

output=$(curl -Lgs "https://${UNIFY_HOST}/proxy/network/integration/v1/sites/${UNIFY_SITEID}/traffic-matching-lists/${UNIFY_TRAFFICMACHINGLISTID_FIRST}" \
     -H "Accept: application/json" \
     -H "X-API-Key: ${UNIFY_APIKEY}" \
     -k)
     
jq <<< ${output}
echo ""
echo "Items count: $(jq '.items | length' <<< ${output})"
