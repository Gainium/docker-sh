# Gainium Docker Compose Setup

> Complete Docker orchestration for the Gainium trading platform with all microservices, databases, and frontend applications.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Environment Configuration](#environment-configuration)
- [Services Overview](#services-overview)
- [Docker Images](#docker-images)
- [Usage Commands](#usage-commands)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)
- [**📋 Changelog**](CHANGELOG.md)

## 🔧 Prerequisites

Before starting, ensure you have:

1. **Docker** (v20.10+) and **Docker Compose** (v2.0+) installed
2. **At least 4GB RAM** and **5GB free disk space**

## ⚡ Quick Start

### 1. Clone and Navigate
```bash
# Clone the repository
git clone https://github.com/Gainium/docker-sh.git

# Navigate into the cloned directory
cd docker-sh
```

### 2. Setup Environment
```bash
# Copy the sample environment file
cp .env.sample .env

# Edit the .env file with your configuration
nano .env  # or use your preferred editor
```

### 3. Configure Variables (Optional)
Edit your `.env` file and configure variables as needed:
```bash
# Coinbase API credentials (only required if using Coinbase)
COINBASEKEY=your_coinbase_api_key
COINBASESECRET=your_coinbase_secret
```

### 4. Start All Services
```bash
# Start all services in background
docker-compose up -d

# View logs (optional)
docker-compose logs -f
```

### 5. Verify Setup
- **API**: http://localhost:7503 (GraphQL endpoint)
- **WebSocket**: ws://localhost:7502 (Real-time data)
- **Frontend**: http://localhost:7500 (Web dashboard)

## 🔧 Environment Configuration

### Optional Variables

| Variable | Description | Example | Required |
|----------|-------------|---------|----------|
| `COINBASEKEY` | Coinbase Pro API Key | `your_api_key` | Only if using Coinbase |
| `COINBASESECRET` | Coinbase Pro API Secret | `your_secret` | Only if using Coinbase |
| `PRICE_CONNECTOR_EXCHANGES` | Comma-separated list of exchanges for websocket price connector | `binance,kucoin,bybit` | No (connects to all if not set) |

### Database Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `MONGO_DB_USERNAME` | `user` | MongoDB username |
| `MONGO_DB_PASSWORD` | `password` | MongoDB password |
| `MONGO_DB_NAME` | `gainium` | Database name |
| `REDIS_PASSWORD` | `H2Ga1DB1alBg` | Redis password |
| `RABBIT_USER` | `gainium` | RabbitMQ username |
| `RABBIT_PASSWORD` | `bdo3nyVMX5l6` | RabbitMQ password |

### Service Ports

| Service | Port | Description |
|---------|------|-------------|
| `GRAPH_QL_PORT` | `7503` | Main API GraphQL endpoint |
| `WS_PORT` | `7502` | WebSocket streaming service |
| `PORT` | `7500` | Frontend web dashboard |
| `BACKTEST_PORT` | `7515` | Backtesting service |

### ⚠️ Important: PRICEROLE Configuration

The `PRICEROLE` environment variable controls how the system handles price updates and can significantly impact resource usage:

| Value | Description | Resource Usage | Use Case |
|-------|-------------|----------------|-----------|
| `all` | **Default** - Connects to both ticker and candle streams | **High** - Real-time ticker updates | Paper trading, high-frequency trading |
| `candle` | Connects only to candle streams, ignores ticker streams | **Low** - Scheduled updates every 2.5 minutes | Live trading without paper trading |
| `ticker` | Connects only to ticker streams | **Medium** - Real-time ticker only | Specific ticker monitoring |

**⚠️ Resource Impact Warning:**
- `PRICEROLE=all` can consume significant resources due to high-frequency ticker updates
- If you're **not using paper trading**, set `PRICEROLE=candle` to reduce resource usage
- With `PRICEROLE=candle`, bot price-related methods run on a schedule every 2.5 minutes instead of real-time

**Example Configuration:**
```bash
# For production without paper trading (recommended)
PRICEROLE=candle

# For development/paper trading (default)
PRICEROLE=all

# For ticker monitoring only
PRICEROLE=ticker
```

### 🔗 PRICE_CONNECTOR_EXCHANGES Configuration

The `PRICE_CONNECTOR_EXCHANGES` environment variable allows you to control which exchanges the websocket price connector connects to for receiving price data.

**Supported Exchanges:**
- `binance` - Binance exchange
- `binanceus` - Binance US exchange  
- `kucoin` - KuCoin exchange
- `bybit` - Bybit exchange
- `okx` - OKX exchange
- `bitget` - Bitget exchange
- `coinbase` - Coinbase exchange

**Configuration Options:**
```bash
# Connect to all exchanges (default behavior)
# Leave variable unset or empty
PRICE_CONNECTOR_EXCHANGES=

# Connect to specific exchanges only
PRICE_CONNECTOR_EXCHANGES=binance,kucoin,bybit

# Connect to a single exchange
PRICE_CONNECTOR_EXCHANGES=binance

# Connect to multiple exchanges
PRICE_CONNECTOR_EXCHANGES=binance,binanceus,coinbase,okx
```

**Important Notes:**
- If `PRICE_CONNECTOR_EXCHANGES` is not set or empty, the connector will connect to **all supported exchanges**
- Use comma-separated values without spaces between exchange names
- Invalid exchange names will be ignored
- This setting affects only the websocket price connector service

### Frontend Runtime Configuration

The frontend service now supports runtime environment variables for server and WebSocket configuration:

```bash
# Default values (for local development)
NEXT_PUBLIC_SERVER=http://localhost:7503
NEXT_PUBLIC_WS=ws://localhost:7502

# For remote deployment, set these to your domain/IP
NEXT_PUBLIC_SERVER=https://api.yourdomain.com
NEXT_PUBLIC_WS=wss://ws.yourdomain.com
```

**Important Notes:**
- These variables are set at **container runtime**, not build time
- Default values work for local development
- For production deployment, update these values to match your server
- **Container must be recreated** when environment variables are changed

**Example Usage:**
```bash
# Local development (uses defaults)
docker-compose up -d

# Production deployment - update docker-compose.yml:
# services:
#   frontend:
#     environment:
#       - NEXT_PUBLIC_SERVER=https://api.mycompany.com
#       - NEXT_PUBLIC_WS=wss://ws.mycompany.com
```


## 🏗️ Services Overview

### Infrastructure Services (3)
- **mongo**: MongoDB database with persistent storage
- **redis**: Redis cache and session store  
- **rabbit**: RabbitMQ message broker

### Connector Services (4)
- **exchange-connector**: Exchange API integration
- **paper-trading**: Paper trading simulation
- **user-update-connector**: Real-time user updates
- **price-connector**: Price data streaming

### Main Application Services (10)
All services share the same codebase but run different commands:

- **api**: GraphQL API server (Port 7503)
- **stream**: WebSocket streaming (Port 7502)
- **bots-dca**: DCA trading bots
- **bots-grid**: Grid trading bots
- **bots-combo**: Combination trading bots
- **bots-hedge-combo**: Hedge combination bots
- **bots-hedge-dca**: Hedge DCA bots
- **indicators**: Technical indicators processor
- **cron**: Scheduled tasks and maintenance
- **backtest**: Strategy backtesting service

### Frontend Service (1)
- **frontend**: Next.js web dashboard (Port 7500)

**Total: 18 Services**

## 🐳 Docker Images

The following images are used from the registry:

| Image | Version | Services Using |
|-------|---------|----------------|
| `docker.gainium.io/gainium/exchange-connector` | `1.0.0` | exchange-connector |
| `docker.gainium.io/gainium/paper-trading` | `1.0.0` | paper-trading |
| `docker.gainium.io/gainium/websocket-connector` | `1.0.0` | user-update-connector, price-connector |
| `docker.gainium.io/gainium/main-app` | `1.0.0` | All 10 main-app services |
| `docker.gainium.io/gainium/frontend` | `1.0.0` | frontend |

**External Images:**
- `bitnami/mongodb:latest`
- `bitnami/redis:latest`  
- `bitnami/rabbitmq:latest`

## 🚀 Usage Commands

### Starting Services

```bash
# Start all services
docker-compose up -d

# Start specific services
docker-compose up -d mongo redis rabbit
docker-compose up -d api frontend

# Start with build (rebuild images)
docker-compose up -d --build

# Start and view logs
docker-compose up
```

### Updating Images

```bash
# Pull latest images from registry
docker-compose pull

# Pull specific image
docker pull docker.gainium.io/gainium/main-app:1.0.0
docker pull docker.gainium.io/gainium/frontend:1.0.0

# Update and restart services
docker-compose pull && docker-compose up -d
```

### Managing Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (⚠️ deletes database data)
docker-compose down -v

# Restart specific service
docker-compose restart api
docker-compose restart frontend

# Scale a service (if supported)
docker-compose up -d --scale bots-dca=2
```

### Monitoring and Debugging

```bash
# View logs for all services
docker-compose logs -f

# View logs for specific service
docker-compose logs -f api
docker-compose logs -f frontend
docker-compose logs -f mongo

# View service status
docker-compose ps

# Execute command in running container
docker-compose exec api bash
docker-compose exec mongo mongosh

# View resource usage
docker stats
```

### Maintenance Commands

```bash
# Update images
docker-compose pull
docker-compose up -d

# Clean up unused resources
docker system prune

# Remove all Gainium images
docker images | grep docker.gainium.io | awk '{print $3}' | xargs docker rmi

# Reset everything (⚠️ deletes all data)
docker-compose down -v --rmi all
```

### Password Reset

To reset a user's password from the command line:

```bash
# Using helper script (recommended)
./resetPassword.sh <username> <newPassword>

# Or using Docker Compose directly
docker-compose run --rm cli-runner npm run cli:reset-password -- <username> <newPassword>
```

**Password Requirements:** Minimum 6 characters with uppercase, lowercase, and a digit.

**Example:**
```bash
./resetPassword.sh admin MyNewPass123
```

## 🔍 Troubleshooting

### Common Issues

#### 1. Service Won't Start - Image Not Found
```bash
# Error: pull access denied or image not found
# Solution: Check image names and tags in docker-compose.yml
docker-compose pull  # Pull all required images
```

#### 2. Service Won't Start - Port Already in Use
```bash
# Find what's using the port
lsof -i :7503
# Kill the process or change the port in .env
```

#### 3. Database Connection Issues
```bash
# Check if MongoDB is running
docker-compose logs mongo
# Reset database
docker-compose restart mongo
```

#### 4. Out of Memory Errors
```bash
# Check available resources
docker stats
# Increase Docker memory limit or reduce running services
```

#### 5. Mac Compatibility Issues (Apple Silicon M1/M2)

**Problem**: Services fail to start on Mac, especially on Apple Silicon chips
```bash
# Common error messages:
# "exec format error"
# "WARNING: The requested image's platform does not match the detected host platform"
# Services keep restarting or fail to start
```

**Solutions**:

**Option 1: Use Docker Desktop Rosetta 2 emulation**
1. Open Docker Desktop
2. Go to Settings → General
3. Check "Use Rosetta for x86/amd64 emulation on Apple Silicon"
4. Restart Docker Desktop
5. Run: `docker-compose down && docker-compose up -d`

**Option 2: Enable Docker experimental features**
```bash
# Enable buildx for multi-platform support
docker buildx create --use
docker buildx inspect --bootstrap

# Pull ARM64 specific images
docker pull --platform linux/arm64 bitnami/redis:latest
docker pull --platform linux/arm64 bitnami/rabbitmq:latest
```

**Option 3: Check Docker Desktop settings**
1. Ensure you're using the latest version of Docker Desktop
2. Go to Settings → Resources and allocate sufficient resources:
   - Memory: At least 4GB
   - CPU: At least 2 cores
3. Restart Docker Desktop

**Verification**:
```bash
# Check if all services are running properly
docker-compose ps

# Check logs for any platform-related errors
docker-compose logs | grep -i "platform\|arch\|format"

# Test database connections
docker-compose exec mongo mongosh --version
docker-compose exec redis redis-cli ping
```

#### 6. Docker Registry Timeout Issues

**Problem**: Docker registry connection timeouts during image pull
```bash
# Common error message:
# "Error response from daemon: Get "https://docker.gainium.io/v2/gainium/main-app/manifests/sha256:..." context deadline exceeded"
```

**Solution**: 
This is typically a network timeout issue when pulling images from the Docker registry. In most cases, simply retrying the command will resolve the issue:

```bash
# Retry pulling images
docker-compose pull

# If pull succeeds, restart the services
docker-compose up -d

# Alternative: Pull specific image that failed
docker pull docker.gainium.io/gainium/main-app:1.0.0
```

**Note**: Registry timeouts are usually temporary network issues. If the problem persists, check your internet connection or try again after a few minutes.

### Debugging Steps

1. **Check service status:**
   ```bash
   docker-compose ps
   ```

2. **View detailed logs:**
   ```bash
   docker-compose logs serviceName
   ```

3. **Test connectivity:**
   ```bash
   # Test API
   curl http://localhost:7503/health
   
   # Test WebSocket
   wscat -c ws://localhost:7502
   ```

4. **Inspect containers:**
   ```bash
   docker-compose exec api bash
   ```

## � Advanced Configuration

### Environment-Specific Setups

Create different environment files:

```bash
# Development
cp .env.sample .env.development

# Production  
cp .env.sample .env.production

# Use specific environment
docker-compose --env-file .env.production up -d
```


### Performance Tuning

```bash
# Limit service resources in docker-compose.yml
services:
  api:
    deploy:
      resources:
        limits:
          memory: 1G
          cpus: '0.5'
```

### Health Checks

Add health checks to monitor service status:

```bash
# Check all services health
docker-compose ps
```

## 📊 Monitoring

### Service Endpoints

- **API Health**: http://localhost:7503/health
- **API GraphQL**: http://localhost:7503/graphql
- **WebSocket**: ws://localhost:7502
- **Frontend**: http://localhost:7500
- **RabbitMQ Management**: http://localhost:15672 (guest/guest)

### Log Management

```bash
# Rotate logs to prevent disk space issues
docker-compose logs --no-log-prefix api > api.log 2>&1
```

## 📝 Important Notes

1. **First Run**: Initial image pull may take 5-10 minutes depending on internet speed
2. **Resource Requirements**: Reduced system requirements (4GB+ RAM recommended)
3. **Data Persistence**: Database data is stored in Docker volumes
4. **Network**: All services communicate on the default Docker bridge network

## 🆘 Getting Help

If you encounter issues:

1. Check this README's troubleshooting section
2. View service logs: `docker-compose logs serviceName`
3. Check Docker resources: `docker stats`
4. Verify environment configuration: `cat .env`

For additional help, contact the Gainium development team with:
- Your `.env` file (with secrets redacted)
- Service logs showing the error
- Output of `docker-compose ps`
