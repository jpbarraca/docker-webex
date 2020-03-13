
docker volume create webex-home
uid=`id -u`
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH

if  ! xauth list | grep -q "$(hostname --short)/unix:0" \
    && ! xauth list | grep -q "$(hostname)/unix:0"; then
    touch ~/.Xauthority
    xauth add ${DISPLAY} . $(mcookie) && echo "new cookie"
fi

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
xhost local:root
docker run -it \
        -v /dev/snd:/dev/snd \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
        --volume=webex-home:/home/webex/ \
        -v /dev/shm:/dev/shm \
        -v /etc/machine-id:/etc/machine-id \
        -v /run/user/$uid/pulse:/run/user/$uid/pulse \
        -v /var/lib/dbus:/var/lib/dbus \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY=$DISPLAY" \
        --user="webex" \
        --name=webex \
        --privileged \
        --net=host \
        --rm \
        webex
