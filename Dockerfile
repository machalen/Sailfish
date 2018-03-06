###########################################################
# Dockerfile to build star container images
# Based on Ubuntu
# sailfish v0.10.0
############################################################

#Build the image based on Ubuntu
FROM ubuntu:latest

#Maintainer and author
MAINTAINER Magdalena Arnal <marnal@imim.es>

#Install required packages in ubuntu for Sailfish
RUN apt-get -y update
RUN apt-get install --yes wget software-properties-common
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x
RUN apt-get install -y \
    cmake \
    libboost-all-dev \
    libtbb-dev \
    g++ \
    zlib1g-dev \
    dialog \
    curl \
    unzip \
    autoconf
RUN apt-get -y upgrade

#Download sailfish and make installation
RUN wget -O sailfish.tar.gz https://github.com/kingsfordgroup/sailfish/archive/v0.10.0.tar.gz
RUN tar xvfz sailfish.tar.gz
RUN mkdir sailfish
RUN cd sailfish
RUN mkdir build
RUN cd build
RUN CXX=g++ cmake -DBOOST_ROOT=/usr/local -DTBB_INSTALL_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/sailfish /sailfish-0.10.0
RUN make -f Makefile
RUN make install
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
ENV PATH $PATH:/sailfish/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/sailfish/lib

#Check if the installation was OK
RUN echo $PATH
RUN echo $LD_LIBRARY_PATH
RUN make test

WORKDIR /
