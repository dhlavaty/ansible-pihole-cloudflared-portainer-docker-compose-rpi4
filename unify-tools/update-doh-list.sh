#! /bin/sh

set -a # automatically export all variables
. ./.env # Most shells use `.` instead of `source`
set +a

# download DoH-IP-blocklists
curl -sSO https://raw.githubusercontent.com/dibdot/DoH-IP-blocklists/refs/heads/master/doh-ipv4.json

# prepare Unify HTTP PUT request
jq --arg name "$UNIFY_TRAFFICMACHINGLISTNAME_FIRST" '{
  type: "IPV4_ADDRESSES",
  name: $name,
  items: map({type: "IP_ADDRESS", value: .})
}' doh-ipv4.json > unify-put-doh-list.json

echo ""
echo "Items count parsed from DoH-IP-blocklists: $(jq '.items | length' unify-put-doh-list.json)"
echo ""

# Make Unify HTTP PUT request
curl -L -g -X PUT "https://${UNIFY_HOST}/proxy/network/integration/v1/sites/${UNIFY_SITEID}/traffic-matching-lists/${UNIFY_TRAFFICMACHINGLISTID_FIRST}" -k \
     -H "X-API-Key: ${UNIFY_APIKEY}" \
     -H "Content-Type: application/json" \
     -d @unify-put-doh-list.json
