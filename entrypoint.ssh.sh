#!/bin/sh
set -e

file=./.ssh/authorized_keys

rm -f $file && touch $file && chown build-dev:build-dev $file

options="no-port-forwarding,no-x11-forwarding,no-agent-forwarding"
IFS=,
for k in $SSH_KEYS; do
  echo "$options $k" >>$file
done

unset IFS

echo $@
exec $@
