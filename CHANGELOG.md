# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Fixed

### Security

## [1.0.16] - 2025-08-29
### Changed
- Updated **exchange-connector** image from **1.0.11 ➜ 1.0.12**: Bybit do not retry 403 error

## [1.0.15] - 2025-08-28
### Changed
- Updated **paper-trading** image from **1.0.6 ➜ 1.0.7**: Fixed type error in addSymbols method
- Updated **exchange-connector** image from **1.0.7 ➜ 1.0.11**: Added Bybit pre launch pairs, fixed Coinbase type error, Kucoin handle error in change margin type method, Binance logs reduced
- Updated **main-app** image from **1.0.15 ➜ 1.1.3**: Updated log level logic, Reset stats when corresponding global variable changed, Optmization of get hedge bot deals stats, Minimum dynamic price deviation, Increase parallel listeners in bot, Calcualte deal profit if deal canceled, but TP order is filled; Fixed Bot not able to be closed if catch error deal not found

## [1.0.14] - 2025-08-05
### Changed
- Updated **main-app** image from **1.0.13 ➜ 1.0.15**: Updates in logic
- Updated **websocket-connector** image from **1.0.9 ➜ 1.0.10**: Binance candle reconnect fix

## [1.0.13] - 2025-07-28
### Changed
- Updated **main-app** image from **1.0.12 ➜ 1.0.13**: Fixed static price filter in multi coin bots

## [1.0.12] - 2025-07-24
### Changed
- Updated **websocket-connector** image from **1.0.8 ➜ 1.0.9**: Bybit fix reconnect after connection closed
- Updated **exchange-connector** image from **1.0.6 ➜ 1.0.7**: Binance futures to drop long requests, Bump dependencies
- Updated **main-app** image from **1.0.11 ➜ 1.0.12**: Retry 500 error, Bumped dependencies versions
- Updated **frontend** image from **1.0.10 ➜ 1.0.11**: Fixed edit global vars in the bot of the same var value
 
## [1.0.11] - 2025-07-22
### Changed
- Updated **frontend** image from **1.0.9 ➜ 1.0.10**: Fixed max number of open deals not shown, false positive disable save DCA bot
- Updated **main-app** image from **1.0.10 ➜ 1.0.11**: Retry request timeout exchange requests
- Updated **paper-trading** image from **1.0.5 ➜ 1.0.6**: Fixed wrong position leverage when open position by limit order

## [1.0.10] - 2025-07-18

### Changed
- Updated **main-app** image from **1.0.9 ➜ 1.0.10**: Backtester update
- Updated **websocket-connector** image from **1.0.7 ➜ 1.0.8**: Bybit reconnect timeout set to 2s
- Updated **frontend** image from **1.0.8 ➜ 1.0.9**: Fixed enter market timeout field, backtester package update

## [1.0.9] - 2025-07-17

### Added
- Increased core compatibilities

### Changed
- Updated **main-app** image from **1.0.8 ➜ 1.0.9**: Enhanced core compatibilities, improved bot dashboard stats for bigAccount configuration

### Fixed
- Fixed bot dashboard stats for bigAccount, prevent showing terminal bots in DCA bots stats

## [1.0.8] - 2025-07-16

### Added
- Support for Bybit regional hosts (com, eu, nl, tr, kz, ge) across all services
- Enhanced exchange factory to support Bybit host parameter selection
- Frontend support for Bybit domain mapping and regional host configuration

### Changed
- Updated **main-app** image from **1.0.7 ➜ 1.0.8**: Added support for changing Bybit host configuration, enhanced exchange factory to support Bybit host parameter, updated bot exchange functionality to support Bybit host selection
- Updated **exchange-connector** image from **1.0.5 ➜ 1.0.6**: Added support for Bybit regional hosts with new BybitHost enum, enhanced Bybit exchange implementation for host selection, updated exchange service and controller to handle Bybit host configuration
- Updated **websocket-connector** image from **1.0.6 ➜ 1.0.7**: Added support for changing Bybit host with configurable WebSocket URLs, enhanced UserConnector for dynamic Bybit host selection
- Updated **frontend** image from **1.0.7 ➜ 1.0.8**: Added support for Bybit domains including various regional hosts and mapping

### Fixed
- Undefined broker code in main app
- Indicator connect timeout issues
- Coinbase pagination in exchange connector

## [1.0.7] - 2025-07-15

### Changed
- Updated **main-app** image from **1.0.6 ➜ 1.0.7**: Added license key validation to user registration form, enhanced license key checking functionality with registration support, snapshot assets aggregation by exchange UUID, updated user registration GraphQL schema to include required license key field, modified license key validation to support both registration and existing user checks, fixed getGlobalVariablesByIds request
- Updated **frontend** image from **1.0.6 ➜ 1.0.7**: Added license key field to registration form with validation, license key requirement for account creation, link to license key generation page in registration form, updated internal dependencies, fixed global variables table API reference issues, improved global variables table layout and responsiveness, fixed DataGrid API state access using proper exportState method, enhanced global variables table height and border styling, fixed coinm deals 0% profit issue, ensure global vars are disabled in combined settings

## [1.0.6] - 2025-07-14

### Changed
- Updated **exchange-connector** image from **1.0.4 ➜ 1.0.5**: Fixed Kucoin futures problem
- Updated **paper-trading** image from **1.0.4 ➜ 1.0.5**: Bumped dependencies
- Updated **main-app** image from **1.0.5 ➜ 1.0.6**: Bumped dependencies, fixed database reference in deal monitor, updated indicator service connection and publish channel logic, enhanced hedge bot to use callback after successful start, fixed TP order size calculation in coinm futures for limit-based orders placed after base order is filled
- Updated **websocket-connector** image from **1.0.5 ➜ 1.0.6**: Bumped dependencies, fixed Bybit ticker issue where only 500 tickers were being used to receive ticker updates

## [0.0.4] - 2025-06-30

### Added
- Persistent storage for **backtest** service:
  - `backtest-candles:/app/loaded-data-candles` – stores loaded candle data
  - `backtest-files:/app/user-files` – stores user backtest files
- Defined `backtest-candles` and `backtest-files` volumes in the `volumes:` section of *docker-compose.yml*

### Changed
- Updated **exchange-connector** image from **1.0.3 ➜ 1.0.4** (amd64 support)
- Updated **paper-trading** image from **1.0.3 ➜ 1.0.4** (amd64 support)
- Updated **main-app** image from **1.0.1 ➜ 1.0.3** (api, bots-dca, bots-grid, bots-combo, bots-hedge-combo, bots-hedge-dca, indicators, cron, stream, backtest) – adds amd64 support
- Updated **websocket-connector** image from **1.0.3 ➜ 1.0.4** (user-update-connector, price-connector) – adds amd64 support
- Updated **frontend** image from **1.0.3 ➜ 1.0.5** – adds amd64 support

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
