###########################################################
# Dockerfile to build with sailfish image
# Based on Ubuntu
############################################################
#Build the image based on Ubuntu
FROM ubuntu:latest

#Author
MAINTAINER Yukimitsu Yabuki, yukimitsu.yabuki@gmail.com

#Install required packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get -y install wget software-properties-common
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x
RUN apt-get -y install cmake libboost-all-dev libtbb-dev g++ zlib1g-dev dialog curl unzip autoconf
RUN apt-get -y upgrade


#Install Sailfish
RUN wget -O sailfish.tar.gz https://github.com/kingsfordgroup/sailfish/archive/v0.10.0.tar.gz
RUN tar xvfz sailfish.tar.gz
RUN mkdir sailfish
RUN cd sailfish
RUN mkdir build
RUN cd build
RUN CXX=g++ cmake -DBOOST_ROOT=/usr/local -DTBB_INSTALL_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/sailfish /sailfish-0.10.0
RUN make
RUN make install
RUN apt-get clean
RUN rm -r /var/lib/apt/lists/*
ENV PATH $PATH:/sailfish/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/sailfish/lib

#Chek if the installation was ok
RUN echo $PATH
RUN echo $LD_LIBRARY_PATH
RUN make test

WORKDIR /

