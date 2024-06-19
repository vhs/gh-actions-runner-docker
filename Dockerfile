FROM ghcr.io/actions/actions-runner:2.317.0

COPY entrypoint.sh /home/runner/

ENTRYPOINT [ "/home/runner/entrypoint.sh" ]
