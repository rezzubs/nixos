# Ports

## Convention

New services get a 10-port block on the tens place, starting at `20000`
(`20000-20009`, `20010-20019`, ...), allocated in the order services are added.
Use the block for every port the service's containers/processes bind to.

Exceptions: a service with a conventionally-expected external port (e.g.
Minecraft clients assuming `25565`) keeps that port instead of moving into the
scheme.

## Common / reserved ranges

Avoid allocating new blocks here — these are used by other things by
convention, not by anything in this repo.

| Range         | What                                                      |
|---------------|-----------------------------------------------------------|
| 0-1023        | Well-known ports (require root to bind)                   |
| 3000-9999     | Common ad-hoc defaults for dev tools and self-hosted apps |
| 32768-60999   | Linux ephemeral port range, used for outgoing connections |

## Allocations

All allocated ports are bound to `127.0.0.1` only. Caddy is the sole intended
entry point for these services, reverse-proxying to them by port. Docker's
own iptables rules bypass the NixOS firewall for published ports, so without
the `127.0.0.1` bind these would be reachable on every interface regardless of
`networking.firewall`.

| Port  | Service       | Notes  |
|-------|---------------|--------|
| 20000 | sftpgo        | HTTP   |
| 20001 | sftpgo        | WebDAV |
| 20010 | actual-budget | HTTP   |
| 20020 | immich        | HTTP   |
| 20030 | jellyfin      | HTTP   |

## Non-conformant

Ports of services which don't map to the scheme above.

| Port  | Service   | Notes                |
|-------|-----------|----------------------|
| 80    | caddy     | HTTP                 |
| 443   | caddy     | HTTPS/HTTP3          |
| 25565 | minecraft | conventional MC port |
