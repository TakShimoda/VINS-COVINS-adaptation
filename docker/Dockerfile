FROM ros:melodic-perception

ENV CERES_VERSION="1.12.0"
ENV CATKIN_WS=/root/catkin_vins

      # set up thread number for building
RUN   if [ "x$(nproc)" = "x1" ] ; then export USE_PROC=1 ; \
      else export USE_PROC=$(($(nproc)/2)) ; fi && \
      apt-get update && apt-get install -y \
      cmake \
      libatlas-base-dev \
      libeigen3-dev \
      libgoogle-glog-dev \
      libsuitesparse-dev \
      python-catkin-tools \
      ros-${ROS_DISTRO}-cv-bridge \
      ros-${ROS_DISTRO}-image-transport \
      ros-${ROS_DISTRO}-message-filters \
      ros-${ROS_DISTRO}-tf && \
      rm -rf /var/lib/apt/lists/* && \
      
      # Build and install Ceres 
      git clone https://ceres-solver.googlesource.com/ceres-solver && \
      cd ceres-solver && \
      git checkout tags/${CERES_VERSION} && \
      mkdir build && cd build && \
      cmake .. && \
      # make -j$(USE_PROC) install && \
      make install && \
      rm -rf ../../ceres-solver && \
      mkdir -p $CATKIN_WS/src/VINS-Fusion/

# Copy VINS-Fusion
COPY ./ $CATKIN_WS/src/VINS-Fusion/
# use the following line if you only have this dockerfile
# RUN git clone https://github.com/HKUST-Aerial-Robotics/VINS-Fusion.git

WORKDIR $CATKIN_WS/src/
# Install Ceres catkin
RUN git clone https://github.com/ethz-asl/ceres_catkin.git && \
    git clone https://github.com/catkin/catkin_simple.git && \
    git clone https://github.com/ethz-asl/opencv3_catkin.git && \
    git clone https://github.com/ethz-asl/eigen_catkin.git && \
    git clone https://github.com/ethz-asl/glog_catkin.git
    
# Build VINS-Fusion
WORKDIR $CATKIN_WS
ENV TERM xterm
ENV PYTHONIOENCODING UTF-8
RUN catkin config \
      --extend /opt/ros/$ROS_DISTRO \
      --cmake-args \
        -DCMAKE_BUILD_TYPE=Release && \
    catkin build -j4 && \
    sed -i '/exec "$@"/i \
            source "/root/catkin_ws/devel/setup.bash"' /ros_entrypoint.sh
