#!/bin/bash

# Specify Config Transpiler version
CT_VER=v0.9.0

# Specify Architecture
# ARCH=aarch64 # ARM's 64-bit architecture
ARCH=x86_64

# Specify OS
# OS=apple-darwin # MacOS
# OS=pc-windows-gnu.exe # Windows
OS=unknown-linux-gnu # Linux

# Specify download URL
DOWNLOAD_URL=https://github.com/coreos/container-linux-config-transpiler/releases/download

# Installation PATH
INSTALLATION_PATH=${HOME}/bin/ct

# Remove previous downloads
rm -f /tmp/ct-${CT_VER}-${ARCH}-${OS} /tmp/ct-${CT_VER}-${ARCH}-${OS}.asc /tmp/coreos-app-signing-pubkey.gpg

# Download Config Transpiler binary
curl -L ${DOWNLOAD_URL}/${CT_VER}/ct-${CT_VER}-${ARCH}-${OS} -o /tmp/ct-${CT_VER}-${ARCH}-${OS}
chmod u+x /tmp/ct-${CT_VER}-${ARCH}-${OS}

# Download and import CoreOS application signing GPG key
curl https://coreos.com/dist/pubkeys/app-signing-pubkey.gpg -o /tmp/coreos-app-signing-pubkey.gpg
gpg2 --import --keyid-format LONG /tmp/coreos-app-signing-pubkey.gpg

# Download and import CoreOS application signing GPG key if it has not already been imported
curl -L ${DOWNLOAD_URL}/${CT_VER}/ct-${CT_VER}-${ARCH}-${OS}.asc -o /tmp/ct-${CT_VER}-${ARCH}-${OS}.asc
gpg2 --verify /tmp/ct-${CT_VER}-${ARCH}-${OS}.asc /tmp/ct-${CT_VER}-${ARCH}-${OS}

# Install CoreOS transpiler
cp /tmp/ct-${CT_VER}-${ARCH}-${OS} ${INSTALLATION_PATH}
echo "CT installed in ${INSTALLATION_PATH}"
