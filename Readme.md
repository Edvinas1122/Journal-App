# Journal App

Container encapsulates CI/CD repositories of microservices used in an app, hosted on Cloudflare's Workers platform.
The app currently accessible via [edvinas.online](https://journal.edvinas.online/) domain.
This way app concers are separated, into develop friendly modular design.

## Using Docker

Docker container used to keep dependencies, like node, npm, node modules, dist files, etc. - therefore keeping the host maschine 'cleaner'.
Another benefit is quick migration. 

## Tunnel network

Container use Cloudflare's tunnels - network forwarding, ngrok like.
This way it will bind to a developer preview domain, supporting live reload, while editing the source code.

## Requirements

- Docker
- 5GB at least (aprox bundle total size 3.5 GB)
