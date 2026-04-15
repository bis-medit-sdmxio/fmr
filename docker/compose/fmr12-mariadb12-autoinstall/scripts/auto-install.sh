#!/bin/sh

set -eu

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

curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  "${BASE_URL}/ws/secure/settings/saveLicenceAgreement"

curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  --data 'Fusion Metadata Registry' \
  "${BASE_URL}/ws/secure/settings/saveRegistryName"

curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  --data '{"username":"root","password":"password","maxLoginAttempts":"-1"}' \
  "${BASE_URL}/ws/secure/settings/saveRootSecuritySettings"

curl --fail --show-error --silent -X POST \
  -H "Cookie: ${COOKIE_HEADER}" \
  -H "Content-Type: application/json" \
  "${BASE_URL}/ws/secure/settings/completeInstall"
