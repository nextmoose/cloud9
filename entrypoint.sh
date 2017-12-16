#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --project-name)
            PROJECT_NAME="${2}" &&
                shift 2
        ;;
        --cloud9-port)
            CLOUD9_PORT="${2}" &&
                shift 2
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
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
        PROJECT_NAME="${PROJECT_NAME}" node /opt/docker/c9sdk/server.js --listen 0.0.0.0 -w /opt/docker/workspace -p ${CLOUD9_PORT}
