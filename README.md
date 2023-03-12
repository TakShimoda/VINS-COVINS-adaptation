# VINS-Fusion Adapatation for COVINS-G

This repository contains an adapted version of the [VINS-fusion](https://github.com/HKUST-Aerial-Robotics/VINS-Fusion) which is adapted to be used with the [COVINS-G](https://github.com/VIS4ROB-lab/covins) (ICRA-23) architecture. Please refer to the [COVINS-G](https://github.com/VIS4ROB-lab/covins) repository for more details on how to use this specific frontend with the collaborative SLAM backend. If you use this version in your academic work, please cite: 

    @article{patel23COVINS_G,
        title = {COVINS-G: A Generic Back-end for Collaborative Visual-Inertial SLAM},
        doi = {10.48550/ARXIV.2301.07147},
        url = {https://arxiv.org/abs/2301.07147},
        author = {Patel, Manthan and Karrer, Marco and Bänninger, Philipp and Chli, Margarita},
        publisher = {arXiv},
        year = {2023},
}

## Installation

Since we mostly test the framework with Ubuntu 20.04 and ROS-Noetic, we use this repository with docker framework (Due to compilation issue of VINS-Fusion on Ubuntu 20.04). Docker environment is like a sandbox, thus makes the code environment-independent. First make sure [ros](http://wiki.ros.org/ROS/Installation) and [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) are installed on your machine. Then add your account to `docker` group by `sudo usermod -aG docker $YOUR_USER_NAME`. **Relaunch the terminal or logout and re-login if you get `Permission denied` error**,

Once you have installed docker and verified its installation, create a catkin workspace:
```
mkdir -p catkin_ws/src
cd catkin_ws/src
```

Clone the Rpository:
```
git clone https://github.com/manthan99/VINS-COVINS-adaptation.git
```

Build Docker:
```
cd ~/catkin_ws/src/VINS-VINS-COVINS-adaptation/docker
make build
```

Note that the docker building process may take a while depends on your network and machine.

For usage in a Collaborative SLAM framework, we refer to the [COVINS-G Repository](https://github.com/VIS4ROB-lab/covins). For settings related to the the frontend parameters, we refer to the original [VINS-fusion repository](https://github.com/HKUST-Aerial-Robotics/VINS-Fusion).

For any issues, please contact Manthan Patel (<manthanhemangpatel@gmail.com>)

**Contributors:** Manthan Patel and Thomas Ziegler ([Vision for Robotics Lab](https://asl.ethz.ch/v4rl.html), ETH Zurich)
