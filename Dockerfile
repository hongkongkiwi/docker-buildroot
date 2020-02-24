FROM ubuntu:18.04

ARG BUILDROOT_BRANCH=2019.11.1

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    curl \
    wget \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    cpio \
    g++ \
    gcc \
    git \
    gzip \
    locales \
    libncurses5-dev \
    libdevmapper-dev \
    libsystemd-dev \
    make \
    mercurial \
    whois \
    patch \
    perl \
    python \
    python3 \
    rsync \
    sed \
    tar \
    unzip \
    bison \
    flex \
    libssl-dev \
    libfdt-dev \
    nano && \
apt autoremove && \
rm -rf /var/lib/apt/lists/*

# Sometimes Buildroot need proper locale, e.g. when using a toolchain
# based on glibc.
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN git clone git://git.buildroot.net/buildroot --depth=1 --branch=${BUILDROOT_BRANCH} /root/buildroot

WORKDIR /root/buildroot

ENV O=/buildroot_output

RUN touch .config
RUN touch kernel.config

VOLUME /root/buildroot/configs
VOLUME /root/buildroot/dl
VOLUME /buildroot_output

RUN ["/bin/bash"]
