#!/bin/sh

if [ -f /home/user/extension/init.root.sh ]
then
    sh /home/user/extension/init.root.sh
fi &&
    if [ -f /home/user/extension/user.sudo ]
    then
        cat /home/user/extension/user.sudo > /etc/sudoers.d/user &&
            chmod 0444 /etc/sudoers.d/user
    fi &&
    if [ -f /home/user/extension/user.id ]
    then
        usermod -u $(cat /home/user/extension/user.id) user
    fi &&
    su -c "sh /home/user/scripts/entrypoint.user.sh \${@}" &&
    shift ${#}
