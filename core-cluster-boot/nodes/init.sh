#!/bin/bash

# utils
log() {
  echo "[$(date +"%T")] ${1}"
}


# configure bootnode
log "preparing bootnode..."
bootnode -addr [::]:10000 -genkey bootnode/bootkey -writeaddress > bootnode/addr


# configure constellation node
log "preparing constellation for node..."
constellation-node --generatekeys=constellation/node

# configure constellation node 2
log "preparing constellation for node2..."
constellation-node --generatekeys=constellation2/node


# configure node
log "preparing constellation for node2..."
geth --datadir node init genesis.json

# configure 2node
log "preparing node..."
geth --datadir node2 init genesis.json
