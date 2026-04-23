#!/bin/sh

set -eu

echo "Autoinstall: acquire session"
BASE_URL="http://fmr:8179"
COOKIE_HEADER="$(
  curl --fail --show-error --silent -D - -o /dev/null \
    "${BASE_URL}/install.html?step=2" \
  | awk 'BEGIN { IGNORECASE = 1 } /^Set-Cookie:/ {
      if (match($0, /JSESSIONID=[^;]+/)) {
        print substr($0, RSTART, RLENGTH)
        exit
      }
    }'
)"

if [ -z "${COOKIE_HEADER}" ]; then
  echo "Failed to extract JSESSIONID from install response" >&2
  exit 1
fi

echo "Autoinstall: accept license agreement"
curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  "${BASE_URL}/ws/secure/settings/saveLicenceAgreement"

echo "Autoinstall: set registry name"
curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  --data 'Fusion Metadata Registry' \
  "${BASE_URL}/ws/secure/settings/saveRegistryName"

echo "Autoinstall: configure root account"
curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  --data '{"username":"root","password":"password","maxLoginAttempts":"-1"}' \
  "${BASE_URL}/ws/secure/settings/saveRootSecuritySettings"

echo "Autoinstall: complete install process"
curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  "${BASE_URL}/ws/secure/settings/completeInstall"

echo "Autoinstall: initialise RBAC role mappings"
curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  --data '{"admins":["Administrator"]}' \
  "${BASE_URL}/ws/secure/settings/security/roleMappings"

echo "Autoinstall: configure OIDC for Keycloak"
curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  --data '{"userDetailsConfig":{"retrievalType":"oidc","issuerUri":"http://localhost:8178/realms/fmr","clientId":"fmrwebapp","clientSecret":"","scopes":"openid,profile,email","groupClaimName":"groups"},"groupDetailsConfig":{},"authType":"oidc"}' \
  "${BASE_URL}/ws/secure/settings/security/authservice"


