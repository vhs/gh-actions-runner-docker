FROM ghcr.io/actions/actions-runner:2.317.0

COPY entrypoint.sh /home/docker/actions-runner

ENTRYPOINT [ "/home/docker/actions-runner/entrypoint.sh" ]
