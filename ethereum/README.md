# Ethereum Archive Node - Erigon 3 + Lighthouse

Complete Docker setup for running an Ethereum archive node with all APIs enabled and accessible.

## System Requirements

- **Disk Space**: ~3TB for Erigon archive node (growing)
- **RAM**: Minimum 16GB, recommended 32GB
- **CPU**: 4+ cores recommended
- **Network**: Stable internet connection with good bandwidth
- **OS**: Linux (recommended), macOS, or Windows with WSL2

## Quick Start

### 1. Setup

```bash
# Make setup script executable
chmod +x setup.sh

# Run setup
./setup.sh
```

This will:
- Create necessary data directories
- Generate JWT secret for Erigon-Lighthouse communication
- Display configuration information

### 2. Start the Node

```bash
docker-compose up -d
```

### 3. Monitor Progress

```bash
# View all logs
docker-compose logs -f

# View only Erigon logs
docker-compose logs -f erigon

# View only Lighthouse logs
docker-compose logs -f lighthouse
```

## API Endpoints

Once running, the following APIs are accessible:

### Erigon (Execution Client)

- **HTTP RPC**: `http://localhost:8545`
  - Methods: `eth`, `debug`, `net`, `trace`, `web3`, `erigon`, `txpool`
  - Example: `curl -X POST http://localhost:8545 -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'`

- **Engine API**: `http://localhost:8551`
  - JWT authenticated (uses `jwt.hex`)
  - Used for Erigon-Lighthouse communication

- **Metrics**: `http://localhost:6060/debug/metrics/prometheus`

### Lighthouse (Consensus Client)

- **Beacon API**: `http://localhost:5052`
  - Full Beacon Node API
  - Example: `curl http://localhost:5052/eth/v1/node/version`

- **Metrics**: `http://localhost:5054/metrics`

## Configuration Details

### Erigon Configuration

The setup includes:
- **Archive mode**: Full historical state (minimal pruning)
- **All APIs enabled**: `eth`, `debug`, `net`, `trace`, `web3`, `erigon`, `txpool`
- **Snapshots enabled**: For faster sync
- **External access**: All endpoints bound to `0.0.0.0`

### Lighthouse Configuration

The setup includes:
- **Checkpoint sync**: Fast sync using trusted checkpoint
- **Historic state reconstruction**: Full archive capability
- **Beacon API**: Full HTTP API enabled
- **External access**: API bound to `0.0.0.0`

## Network Ports

| Port | Protocol | Service | Purpose |
|------|----------|---------|---------|
| 30303 | TCP/UDP | Erigon | P2P networking |
| 8545 | TCP | Erigon | HTTP RPC API |
| 8551 | TCP | Erigon | Engine API (JWT) |
| 6060 | TCP | Erigon | Metrics |
| 9000 | TCP/UDP | Lighthouse | P2P networking |
| 5052 | TCP | Lighthouse | Beacon API |
| 5054 | TCP | Lighthouse | Metrics |

## Security Considerations

⚠️ **Important**: This configuration exposes APIs on all interfaces (`0.0.0.0`). Consider:

1. **Firewall Rules**: Restrict access to API ports (8545, 8551, 5052, 6060, 5054)
2. **Reverse Proxy**: Use nginx or similar for additional security and rate limiting
3. **VPN/Private Network**: Run on private network if possible
4. **JWT Secret**: Keep `jwt.hex` secure - it's required for Engine API access

## Sync Times

- **Lighthouse**: 5-10 minutes (using checkpoint sync)
- **Erigon Archive**: 3-7 days depending on hardware and network

## Monitoring Sync Progress

### Check Erigon Sync Status

```bash
curl -X POST http://localhost:8545 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}'
```

Returns `false` when fully synced, or sync progress object if still syncing.

### Check Lighthouse Sync Status

```bash
curl http://localhost:5052/eth/v1/node/syncing
```

## Useful Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# Restart services
docker-compose restart

# View logs
docker-compose logs -f

# Check container status
docker-compose ps

# Update to latest images
docker-compose pull
docker-compose up -d

# Remove everything (including data)
docker-compose down -v
rm -rf erigon-data lighthouse-data jwt.hex
```

## Accessing from External Machines

To access the APIs from other machines on your network:

1. Replace `localhost` with your server's IP address
2. Ensure firewall allows connections on the required ports
3. Example: `http://192.168.1.100:8545`

## Example API Calls

### Get Latest Block Number (Erigon)

```bash
curl -X POST http://localhost:8545 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'
```

### Get Block by Number (Erigon)

```bash
curl -X POST http://localhost:8545 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x1",true],"id":1}'
```

### Get Beacon Head (Lighthouse)

```bash
curl http://localhost:5052/eth/v1/beacon/headers/head
```

### Get Validator Status (Lighthouse)

```bash
curl http://localhost:5052/eth/v1/beacon/states/head/validators
```

## Troubleshooting

### Erigon won't start
- Check disk space: `df -h`
- Check logs: `docker-compose logs erigon`
- Verify JWT file exists: `ls -la jwt.hex`

### Lighthouse won't connect to Erigon
- Verify JWT secret matches: `cat jwt.hex`
- Check Erigon Engine API is accessible: `docker-compose logs erigon | grep 8551`
- Ensure both containers are on same network: `docker network inspect ethereum_ethereum`

### Slow sync
- Check hardware: Archive nodes need fast NVMe SSD
- Monitor resources: `docker stats`
- Check network: Ensure good connectivity

### Out of disk space
- Archive mode requires ~3TB minimum
- Monitor growth: `du -sh erigon-data lighthouse-data`

## Support & Resources

- **Erigon**: https://github.com/ledgerwatch/erigon
- **Lighthouse**: https://lighthouse-book.sigmaprime.io/
- **Ethereum JSON-RPC**: https://ethereum.org/en/developers/docs/apis/json-rpc/

## License

This configuration is provided as-is for running Ethereum infrastructure.
