# gh-actions-runner-docker

A wafer-thin mint entrypoint wrapper for the official self-hosted GitHub Actions Runners Docker image.

## Usage

### Environment Variables

| Variables    | Description                                                                                   |
| ------------ | --------------------------------------------------------------------------------------------- |
| GH_URI       | The short form GitHub id.<br />I.e. `vhs` as an org or `vhs/tacos` for a specific repository. |
| GH_REG_TOKEN | The GitHub runner registration token.                                                         |

### Docker

Example:
`docker run -d -e GH_URI=vhs -e GH_REG_TOKEN=RANDOMTOKENSTRING ghcr.io/vhs/gh-actions-runner-docker:latest`

### Docker Compose

Example compose configuration:

```yaml
services:
  runner:
    image: ghcr.io/vhs/gh-actions-runner-docker:latest
    restart: always
    env_file:
      - runners.env
    deploy:
      mode: replicated
      replicas: 4
      resources:
        limits:
          cpus: '0.35'
          memory: 300M
        reservations:
          cpus: '0.25'
          memory: 128M
```

Example runners.env file:

```env
GH_URI=vhs
GH_REG_TOKEN=RANDOMTOKENSTRING
```

## Acknowledgements

Entrypoint script derived from work by Alessandro Baccini.

https://github.com/beikeni/github-runner-dockerfile/LICENSE
