#!/bin/sh
set -e

file="$(getent passwd build-dev |cut -d ':' -f 6)/.ssh/authorized_keys"

rm -f $file && touch $file && chown build-dev:build-dev $file

options="no-x11-forwarding,no-agent-forwarding"
IFS=,
for k in $SSH_KEYS; do
  echo "$options $k" >>$file
done

unset IFS

echo $@
exec $@
