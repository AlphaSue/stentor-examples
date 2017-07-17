#!/bin/bash

set -eu -o pipefail

# install build deps
add-apt-repository ppa:ethereum/ethereum
apt-get update
apt-get install -y build-essential unzip libdb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

# install constellation
CONSTELLATION_VERSION=0.1.0
CONSTELLATION_FILE="constellation-${CONSTELLATION_VERSION}-ubuntu1604" 

wget -q https://github.com/jpmorganchase/constellation/releases/download/v${CONSTELLATION_VERSION}/${CONSTELLATION_FILE}.tar.xz
tar xvf ${CONSTELLATION_FILE}.tar.xz
cp ${CONSTELLATION_FILE}/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
cp ${CONSTELLATION_FILE}/constellation-enclave-keygen /usr/local/bin && chmod 0755 /usr/local/bin/constellation-enclave-keygen
rm -rf ${CONSTELLATION_FILE}.tar.xz ${CONSTELLATION_VERSION}

# install golang
GOREL=go1.7.3.linux-amd64.tar.gz
wget -q https://storage.googleapis.com/golang/$GOREL
tar xfz $GOREL
mv go /usr/local/go
rm -f $GOREL
PATH=$PATH:/usr/local/go/bin
echo 'PATH=$PATH:/usr/local/go/bin' >> /home/ubuntu/.bashrc

# make/install quorum
git clone https://JullienSue@bitbucket.org/joch-/stentor-block-chain.git
pushd stentor-block-chain >/dev/null
# git checkout tags/v1.1.0
make all

cp build/bin/geth /usr/local/bin
cp build/bin/bootnode /usr/local/bin
popd >/dev/null

# done!
banner "Stentor"
echo
echo 'The Stentor vagrant instance has been provisioned. Examples are available in ~/stentor-examples inside the instance.'
echo "Use 'vagrant ssh' to open a terminal, 'vagrant suspend' to stop the instance, and 'vagrant destroy' to remove it."