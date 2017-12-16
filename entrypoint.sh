#!/bin/sh

if [ -f /opt/docker/extension/cleanup.sh ]
then
    cleanup() {
        sh /opt/docker/extension/cleanup.sh
    } &&
    trap cleanup EXIT
fi &&
    if [ -f /opt/docker/extension/init.user.sh ]
    then
        sh /opt/docker/extension/init.user.sh "${@}"
    fi &&
    export CLOUD9_PORT=18688 &&
    source /opt/docker/entrypoint.env &&
    PROJECT_NAME="${PROJECT_NAME}" node /opt/docker/c9sdk/server.js --listen 0.0.0.0 -w /workspace -p ${CLOUD9_PORT}
