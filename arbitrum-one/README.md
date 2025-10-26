
Get last release here: [https://hub.docker.com/r/offchainlabs/nitro-node/tags](https://hub.docker.com/r/offchainlabs/nitro-node/tags)
```bash
docker run -d -it --restart=unless-stopped --name arb1-node \
  -v /home/laviedeskiwis66/.arbitrum:/home/user/.arbitrum \
  -p 0.0.0.0:8547:8547 \
  -p 0.0.0.0:8548:8548 \
  -p 0.0.0.0:6070:6070 \
  offchainlabs/nitro-node:v3.6.4-rc.1-28199cd \
  --parent-chain.connection.url=EL_CLIENT_RPC_URL \
  --chain.id=42161 \
  --http.api=net,web3,eth \
  --http.corsdomain=* \
  --http.addr=0.0.0.0 \
  --http.vhosts=* \
  --init.latest=pruned \
  --ws.port=8548 \
  --ws.addr=0.0.0.0 \
  --ws.origins=* \
  --parent-chain.blob-client.beacon-url=BEACON_CLIENT_RPC_URL \
  --metrics \
  --metrics-server.addr=0.0.0.0 \
  --metrics-server.port=6070
```
