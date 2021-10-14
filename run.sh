#!/bin/sh

remote_port=
local_port=
identity_file=
ssh_port=
ssh_user=
ssh_host=

log_file="${0}.log"
command='ssh -f -N -T'
command="${command} -o ServerAliveInterval=10"
command="${command} -o ServerAliveCountMax=3"
command="${command} -o ExitOnForwardFailure=yes"
command="${command} -o TCPKeepAlive=no"
command="${command} -R ${remote_port}:localhost:${local_port}"
command="${command} -i ${identity_file}"
command="${command} -p ${ssh_port}"
command="${command} ${ssh_user}@${ssh_host}"

get_date() {
  date="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "${date}"
}

pgrep -f -x "${command}" > /dev/null 2>&1
result="${?}"

if [ "${result}" -ne 0 ]; then
  echo "$(get_date) Tunnel disconnected: ${command}" >> "${log_file}"
  $command
  echo "$(get_date) Re-established tunnel: ${command}" >> "${log_file}"
fi
