#!/usr/bin/env bash

apt-get -y update 
#apt-get -y upgrade 
apt-get -y install build-essential
apt-get -y install g++
apt-get -y install gcc

# --Tools 
apt-get -y install vim 
apt-get -y install ddd 
apt-get -y install gdb 
apt-get -y install valgrind
apt-get -y install git
apt-get -y install gitk

# --Libs
# c++ dev
apt-get -y install libboost-all-dev

apt-get -y install libx11-6 
apt-get -y install libx11-dev

apt-get -y install freeglut3
apt-get -y install freeglut3-dev

# OpenGL context creation
apt-get -y install libsfml-dev

# FFmpeg
apt-get -y install libavcodec-dev
apt-get -y install libavformat-dev
apt-get -y install libswscale-dev
apt-get -y install ffmpeg

apt-get -y install libdc1394-22-dev

# Image libraries
apt-get -y install libtiff4
apt-get -y install libtiff4-dev
apt-get -y install libjpeg8
apt-get -y install libjpeg-turbo8
apt-get -y install libjpeg8-dev
apt-get -y install libjpeg-turbo8-dev
apt-get -y  install libpng12-0
apt-get -y  install libpng12-dev

apt-get -y install liblapack3gf
apt-get -y install liblapack-dev
apt-get -y install liblapack-doc

apt-get -y install libblas3gf
apt-get -y install libblas-dev
apt-get -y install libblas-doc

# Useful for GVars
apt-get -y install libreadline-dev
apt-get -y install ncurses-dev #might be not needed

cd $HOME

# TooN
if [ ! -f /.tooninstalled ]; then
    echo "Provisioning TooN."
    git clone git://github.com/edrosten/TooN.git
    git pull origin master
    cd TooN
    ./configure
    make
    make install
    cd ../
    touch /.tooninstalled
else
    echo "TooN already installed."
fi

# LibCVD
if [ ! -f /.libcvdinstalled ]; then
    echo "Provisioning libcvd."
    git clone git://github.com/edrosten/libcvd.git
    git pull origin master
    cd libcvd
    export CXXFLAGS=-D_REENTRANT
    ./configure --enable-gpl
    make
    make install
    cd ../
    touch /.libcvdinstalled
else
    echo "LibCVD already installed."
fi

# GVars                                                                                                                            
if [ ! -f /.gvarsinstalled ]; then
    echo "Provisioning Gvars."
    git clone https://github.com/edrosten/gvars.git
    git pull origin master
    cd gvars
    ./configure --disable-widgets
    make
    make install
    cd ../
    touch /.gvarsinstalled
else
    echo "GVars already installed."
fi


# Add sync folder
mkdir -p "/vagrant/sync"
chown -R vagrant:vagrant "/vagrant/sync/"

# Link sync directory into home
if [[ ! -L "/home/vagrant/sync" ]]; then
  ln -s "/vagrant/sync" "/home/vagrant/sync"
fi