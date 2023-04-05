#!/bin/sh

usage()
{
     echo "run.sh [-h|--help] [:VERSION] [COMMAND] [ARG...]"
     exit 1
}

case "$1" in
     :*)  tag=$1
          shift
          ;;

     -h|--help)
          usage
          ;;
esac


DOCKER_MAJOR_VERSION=$(docker version --format '{{.Client.Version}}' | cut -d. -f1)
AMD_GPU=$(lspci | grep "VGA" | grep "AMD")
if [ -n "$AMD_GPU" ]; then
     readonly RUNTIME=""
elif [ $DOCKER_MAJOR_VERSION -ge 19 ] && which nvidia-docker > /dev/null; then
     readonly RUNTIME="--gpus all"
else
     readonly RUNTIME="--runtime=nvidia"
fi

echo $RUNTIME

docker run -it --name --rm \
  --user=$(id -u $USER):$(id -g $USER) \
  --group-add=27 \
  --workdir="/home/$USER" \
  --volume="/home/$USER:/home/$USER" \
  --volume="/etc/group:/etc/group:ro" \
  --volume="/etc/passwd:/etc/passwd:ro" \
  --volume="/etc/shadow:/etc/shadow:ro" \
  --volume="/etc/sudoers.d:/etc/sudoers.d:rw" \
  --volume="/etc/udev:/etc/udev" \
  --privileged \
  --device=/dev/ttyS0 \
  $RUNTIME \
  --net=host \
  -e DISPLAY \
  -e XAUTHORITY=/tmp/.Xauthority \
  -v ${XAUTHORITY}:/tmp/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  groot:groot bash \
  -c "/usr/src/third_party/Groot/build/./Groot"
