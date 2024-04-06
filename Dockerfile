FROM ubuntu:18.04

# Avoid warnings by switching to noninteractive
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

# Configure APT --> HERE THE WARNINGS 'debconf: unable to initialize frontend: Dialog' ARE NOT DISPLAYED
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y \
    apt-utils \
    dialog \
    fakeroot \
    software-properties-common \
    2>&1

# Install APT packages --> HERE THE WARNINGS 'debconf: unable to initialize frontend: Dialog' ARE NOT DISPLAYED
RUN apt-get update && apt-get install -y \
    #
    # System packages
    iproute2 \
    procps \
    lsb-release \
    sudo \
    unattended-upgrades \
    dnsutils \
    iputils-ping \
    xauth \
    openssl \
    tar \
    zip \
    #
    # Helpers
    && apt-get install -y \
    ca-certificates \
    curl \
    wget \
    lsof \
    gconf2 \
    gconf-service \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# Install LTE stack dependencies --> HERE THE WARNINGS 'debconf: unable to initialize frontend: Dialog' ARE DISPLAYED
RUN chmod +x ./setup/install.sh \
    ./setup/install.sh
