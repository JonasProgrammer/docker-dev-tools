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

if [ ! -f /etc/ssh/ssh_host_keys_flag ]; then
  echo "Recreating SSH host keys (touch /etc/ssh/ssh_host_keys_flag to disable)..."
  rm -f /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_ed25519_key

  ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
  ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key.pub

  ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
  ssh-keygen -l -f /etc/ssh/ssh_host_ecdsa_key.pub

  ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
  ssh-keygen -l -f /etc/ssh/ssh_host_ed25519_key.pub

  touch /etc/ssh/ssh_host_keys_flag
fi

echo $@
exec $@
