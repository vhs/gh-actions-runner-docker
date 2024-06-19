#!/usr/bin/env bash

if [ "${GH_URI}" = "" ]; then
    echo "ERROR: Missing GH_URI variable. Bailing..."

    exit 255
fi

if [ "${GH_REG_TOKEN}" = "" ]; then
    echo "ERROR: Missing GH_REG_TOKEN variable. Bailing..."

    exit 254
fi

cd "$(dirname "$(realpath "$0")")" || exit 253

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token "${GH_REG_TOKEN}"
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

if [ "$*" = "" ]; then
    RUNNER_OPTS="--unattended --replace --url https://github.com/${GH_URI} --token ${GH_REG_TOKEN}"

    if [ "${GH_RUNNER_NAME}" != "" ]; then
        RUNNER_OPTS=$(echo "${RUNNER_OPTS} --name ${GH_RUNNER_NAME}")
    fi

    echo "Configuring runner..."
    ./config.sh "${RUNNER_OPTS}"

    ./run.sh &
    wait $!
else
    exec "$@"
fi
