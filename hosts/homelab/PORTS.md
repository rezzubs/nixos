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

| Port  | Service | Purpose |
|-------|---------|---------|
| 20000 | *(TBD)* |         |

## Non-conformant

Ports of services which don't map to the scheme above.

| Port  | Service               | Notes                |
|-------|-----------------------|----------------------|
| 80    | caddy                 | HTTP                 |
| 443   | caddy                 | HTTPS/HTTP3          |
| 2283  | immich (immich_server)|                      |
| 5006  | actual-budget         |                      |
| 8080  | sftpgo                | admin UI             |
| 9090  | sftpgo                | WebDAV               |
| 25565 | minecraft             | conventional MC port |
