#!/bin/bash
set -eu

hosts_file="/etc/hosts"
tmp_file="$(mktemp)"

cleanup() {
  rm -f "$tmp_file"
}
trap cleanup EXIT

# Resolve host.docker.internal and take only the IP from the first line
docker_ip="$(
  getent ahosts host.docker.internal \
    | awk 'NR == 1 { print $1; exit }'
)"

if [[ -z "${docker_ip:-}" ]]; then
  echo "Error: could not resolve host.docker.internal" >&2
  exit 1
fi

# Process /etc/hosts
cat /etc/hosts | grep -v localhost | grep -v 127.0.0.1 | awk -v new_ip="$docker_ip" '
    {
        print
    }

    END {
        print new_ip " localhost"
        print "127.0.0.1 loopback"
    }
' > "$tmp_file" || {
  echo "Error: failed to rewrite $hosts_file" >&2
  exit "$?"
}

cat "$tmp_file" > "$hosts_file"

echo "Updated localhost -> $docker_ip"