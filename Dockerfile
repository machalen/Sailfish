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
RUN apt-get update
RUN apt-get install --yes wget software-properties-common
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x
RUN apt-get install -y \
    wget \
    gcc-multilib \
    apt-utils \
    git \
    libtbb-dev \
    wget \
    zlib1g-dev \
    python \
    perl \
    perl-base \
    r-base \
    r-base-core \
    r-base-dev
