
Get last release here: [https://hub.docker.com/r/offchainlabs/nitro-node/tags](https://hub.docker.com/r/offchainlabs/nitro-node/tags)

Archive node:
```bash
docker run -d -it --restart=unless-stopped --name arb1-node \
  -v /home/$USER/.arbitrum:/home/user/.arbitrum \
  -p 0.0.0.0:8547:8547 \
  -p 0.0.0.0:8548:8548 \
  -p 0.0.0.0:6070:6070 \
  offchainlabs/nitro-node:ARB1_LATEST_IMAGE \
  --parent-chain.connection.url=EL_CLIENT_RPC_URL \
  --chain.id=42161 \
  --http.api=net,web3,eth \
  --http.corsdomain=* \
  --http.addr=0.0.0.0 \
  --http.vhosts=* \
  --init.latest=archive \
  --ws.port=8548 \
  --ws.addr=0.0.0.0 \
  --ws.origins=* \
  --parent-chain.blob-client.beacon-url=BEACON_CLIENT_RPC_URL \
  --metrics \
  --metrics-server.addr=0.0.0.0 \
  --metrics-server.port=6070
```

Full node:
```bash
docker run -d -it --restart=unless-stopped --name arb1-node \
  -v /home/$USER/.arbitrum:/home/user/.arbitrum \
  -p 0.0.0.0:8547:8547 \
  -p 0.0.0.0:8548:8548 \
  -p 0.0.0.0:6070:6070 \
  offchainlabs/nitro-node:ARB1_LATEST_IMAGE \
  --parent-chain.connection.url=EL_CLIENT_RPC_URL \
  --chain.id=42161 \
  --http.api=net,web3,eth \
  --http.corsdomain=* \
  --http.addr=0.0.0.0 \
  --http.vhosts=* \
  --init.latest=pruned \
  --init.prune=full \
  --ws.port=8548 \
  --ws.addr=0.0.0.0 \
  --ws.origins=* \
  --parent-chain.blob-client.beacon-url=BEACON_CLIENT_RPC_URL \
  --metrics \
  --metrics-server.addr=0.0.0.0 \
  --metrics-server.port=6070
```
