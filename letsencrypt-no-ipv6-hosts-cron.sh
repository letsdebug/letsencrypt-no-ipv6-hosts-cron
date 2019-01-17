#!/usr/bin/env bash
set -euf -o pipefail

HOSTSFILE="/etc/hosts"

# Use the `host` command to extract the IPv4 address
IP4=$(host -c IN -t A acme-v02.api.letsencrypt.org | awk '/has address/ { print $4 ; exit }')

# Sanity check on what we found
if [[ ! $IP4 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "$IP4 is not IP"
  exit 1
fi

# If there is already a line for this domain, we must replace it
if grep -qE "^[0-9].*acme-v02.api.letsencrypt.org" "$HOSTSFILE"; then
  to_replace=$(grep -Em 1 "^[0-9].*acme-v02.api.letsencrypt.org$" "$HOSTSFILE")
  sed -i "s/$to_replace/$IP4 acme-v02.api.letsencrypt.org/" "$HOSTSFILE"
else
  # Otherwise we are adding a new line
  printf "%s acme-v02.api.letsencrypt.org\n" "$IP4" >> "$HOSTSFILE"
fi