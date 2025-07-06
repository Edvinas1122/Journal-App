# Journal App Dev Container

Container encapsulates Automated deployment repositories of microservices used in an app, hosted on Cloudflare's Workers platform.
The app currently accessible via [edvinas.online](https://journal.edvinas.online/) domain.
This way app concers are separated, into develop friendly modular design.

## Using Docker

Docker container used to keep dependencies, like node, npm, node modules, dist files, etc. - therefore keeping the host maschine 'cleaner'.
Another benefit is quick migration. 

## Tunnel network

Container use Cloudflare's tunnels - network forwarding, ngrok like.
This way it will bind to a developer preview domain, supporting live reload, while editing the source code.
When container is up it is hosted on [here](https://dev.edvinas.online).

## Requirements

- **Docker**
- **Disk space:** 5GB at least (approx. bundle total size 3.5 GB)

### CPU Recommendations

- **Minimum:** Dual-core CPU (e.g., Intel i3, Apple M1, or equivalent)
- **High-performace (Mid-tier):** Quad-core CPU (e.g., Intel i5/i7, Apple M1/M2, Ryzen 5 or better)
