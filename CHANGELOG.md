# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.3] - 2025-06-30

### Fixed
- Added missing required environment variables to .env.sample file
  - Added NEXT_PUBLIC_SERVER=http://localhost:7503
  - Added NEXT_PUBLIC_WS=ws://localhost:7502

## [0.0.2] - 2025-06-27

### Security
- Updated paper-trading, exchange-connector, and websocket-connector images to use newer packages and software to fix known vulnerabilities

## [0.0.1] - 2025-06-26

### Changed
- **CRITICAL FIX**: Updated exchange-connector from 1.0.1 to 1.0.2 - fixes critical issue with real exchange credential handling
- Updated paper-trading from 1.0.1 to 1.0.2
- Updated websocket-connector (user-update-connector and price-connector) from 1.0.1 to 1.0.2

### Added
- Frontend now supports runtime environment variables for server and WebSocket configuration
- Runtime variables: `NEXT_PUBLIC_SERVER` (defaults to `http://localhost:7503`) and `NEXT_PUBLIC_WS` (defaults to `ws://localhost:7502`)
- Environment variables can be set at container runtime for deployment to remote servers

### Previous Changes
- Updated all service images from version 1.0.0 to 1.0.1
- Improved Docker service health checks and startup times
  - Reduced MongoDB start_period from 120s to 45s
  - Reduced Redis start_period from 60s to 30s
  - Added health checks to all application services (exchange-connector, paper-trading, api, user-update-connector, bots services, indicators, cron, stream, backtest, price-connector, frontend)
  - Updated service dependencies to use `service_healthy` condition instead of `service_started` for better reliability
  - Standardized health check configurations across services with 30s intervals, 10s timeouts, and 3 retries
  - Set appropriate start_period values (10s for most services, longer for API services)

### Technical Details
- **Frontend Runtime Configuration:** Frontend applications now handle their configuration through runtime environment variables instead of build-time injection
  - Default values: `NEXT_PUBLIC_SERVER=http://localhost:7503` and `NEXT_PUBLIC_WS=ws://localhost:7502`
  - For remote deployment: Set these variables to your domain name or IP address
  - **Important**: Container must be recreated when environment variables are changed
- Health checks use wget to test `/health` endpoints on appropriate ports
- All bot services now properly wait for their dependencies to be healthy before starting
- Frontend service now depends on API being healthy rather than just started
- Improved overall service orchestration and startup reliability

---

## Release Notes

This changelog tracks changes for the docker-sh configuration repository. 
When ready for release, the [Unreleased] section will be moved to a versioned release section.

Since this is a beta project, versions follow 0.x.y semantic versioning where:
- 0.x.0 for minor feature releases
- 0.x.y for patches and bug fixes
