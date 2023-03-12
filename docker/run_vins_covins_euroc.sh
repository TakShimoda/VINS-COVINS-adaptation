#!/bin/bash
trap : SIGTERM SIGINT

AG_N="0"

echo "Agent Number: $1";

AG_N=$1;

function absPath() 
{
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 = /* ]]; then
            echo "$1"
        elif [[ $1 == */* ]]; then
            echo "$(cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}

VINS_FUSION_DIR=$(absPath "..")
CONFIG_IN_DOCKER="/root/catkin_ws/src/VINS-Fusion/config/euroc/euroc_mono_imu_config.yaml"

docker run \
-it \
--rm \
--net=host \
-v ${VINS_FUSION_DIR}:/root/catkin_ws/src/VINS-Fusion/ \
ros:vins-fusion \
/bin/bash -c \
"cd /root/catkin_ws/; \
catkin config \
        --env-cache \
        --extend /opt/ros/$ROS_DISTRO \
    --cmake-args \
        -DCMAKE_BUILD_TYPE=Release; \
    catkin build; \
    source devel/setup.bash; \
    roslaunch vins vins_covins.launch config:=${CONFIG_IN_DOCKER} ag_n:=${AG_N}"
    
wait $ROSCORE_PID
wait $RVIZ_PID

if [[ $? -gt 128 ]]
then
    kill $ROSCORE_PID
    kill $RVIZ_PID
fi
