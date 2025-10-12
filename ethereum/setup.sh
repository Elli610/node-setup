#!/bin/bash

# Ethereum Archive Node Setup Script
# For Erigon 3 + Lighthouse

set -e

echo "=== Ethereum Archive Node Setup ==="
echo ""

# Create data directories
echo "Creating data directories..."
mkdir -p erigon-data
mkdir -p lighthouse-data

# Generate JWT secret if it doesn't exist
if [ ! -f jwt.hex ]; then
    echo "Generating JWT secret..."
    openssl rand -hex 32 > jwt.hex
    echo "JWT secret generated: jwt.hex"
else
    echo "JWT secret already exists: jwt.hex"
fi

# Set proper permissions
echo "Setting permissions..."
chmod 644 jwt.hex

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Data directories created:"
echo "  - ./erigon-data"
echo "  - ./lighthouse-data"
echo ""
echo "JWT secret: ./jwt.hex"
echo ""
echo "Available API endpoints (after starting):"
echo "  - Erigon HTTP RPC:    http://localhost:8545"
echo "  - Erigon Engine API:  http://localhost:8551 (JWT required)"
echo "  - Erigon Metrics:     http://localhost:6060"
echo "  - Lighthouse API:     http://localhost:5052"
echo "  - Lighthouse Metrics: http://localhost:5054"
echo ""
echo "To start the node, run:"
echo "  docker-compose up -d"
echo ""
echo "To view logs:"
echo "  docker-compose logs -f"
echo ""
echo "To stop the node:"
echo "  docker-compose down"
echo ""
echo "IMPORTANT NOTES:"
echo "  1. Erigon archive node requires ~3TB of disk space"
echo "  2. Initial sync will take several days"
echo "  3. Lighthouse will use checkpoint sync for faster startup"
echo "  4. All APIs are exposed on 0.0.0.0 - configure firewall appropriately"
echo ""
