# Reverse SSH Tunnel #

## Description ##

A simple script for creating a reverse SSH tunnel.

## Requirements ##

* OpenSSH client.

## Installation ##

0. Clone the repository and deploy to the computer.

## Configuration ##

Generate SSH key for connecting from local computer to remote computer.

Modify the following variables in the shell script `run.sh`:

* `remote_port`: The port on the remote computer that the traffic will be
                 forwarded from.
* `local_port`: The port on the local computer that the traffic will be
                forwarded to.
* `identity_file`: The SSH private key.
* `ssh_port`: The SSH port listened on the remote computer.
* `ssh_user`: The user to login on the remote computer.
* `ssh_host`: The host of the remote computer.

## Usage ##

Run:

```
sh run.sh
```

On first run, the command used to establish the reverse SSH tunnel will be
printed.

If the tunnel has been established, nothing will be printed.

You may want to use `cron(8)` to run the periodically to make sure the tunnel is
established.

```
# Run the script every 5 minutes.
*/5 * * * * /bin/sh /path/to/run.sh
```

In some cases, the tunnel may be disconnected after several minutes of
inactivity. For example, if you use reverse SSH tunnel to forward HTTP traffic
from the HAProxy on remote computer to local computer, you can enable health
check:

```
# Health check every 5 seconds.
backend backend-01
  server server-01 127.0.0.1:8080 check inter 5s
```

## References

* [Reverse ssh tunnel を安定運用する](https://qiita.com/syoyo/items/d31e9db6851dfee3ef82)
* [SSH port forwarding - Example, command, server config](https://www.ssh.com/academy/ssh/tunneling/example#remote-forwarding)

## License ##

[The BSD 3-Clause License](http://opensource.org/licenses/BSD-3-Clause)
