#! /bin/sh

set -a # automatically export all variables
. ./.env # Most shells use `.` instead of `source`
set +a

# download dnscrypt-blocklists
curl -sSO https://raw.githubusercontent.com/dhlavaty/dnscrypt-blocklists/refs/heads/main/ipv4.json

# prepare Unify HTTP PUT request
jq --arg name "$UNIFY_TRAFFICMACHINGLISTNAME_SECOND" '{
  type: "IPV4_ADDRESSES",
  name: $name,
  items: map({type: "IP_ADDRESS", value: .})
}' ipv4.json > unify-put-dnscrypt-list.json

echo ""
echo "Items count parsed from DNSCrypt-blocklists: $(jq '.items | length' unify-put-dnscrypt-list.json)"
echo ""

# Make Unify HTTP PUT request
curl -L -g -X PUT "https://${UNIFY_HOST}/proxy/network/integration/v1/sites/${UNIFY_SITEID}/traffic-matching-lists/${UNIFY_TRAFFICMACHINGLISTID_SECOND}" -k \
     -H "X-API-Key: ${UNIFY_APIKEY}" \
     -H "Content-Type: application/json" \
     -d @unify-put-dnscrypt-list.json
