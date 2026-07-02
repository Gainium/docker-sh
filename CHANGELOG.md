# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Fixed

- **Paper & live orders now fill on self-hosted (notably Coinbase).** The single
  price connector ran the `candle` role, so it never produced the
  `trade@{sym}@{exchange}` ticker feed that paper-trading (and live fill tracking)
  consume — orders silently never filled. The connector is now pinned to the
  `all` role in `docker-compose.yml` (produces candle streams **and** the ticker
  feed). Hardcoded, so existing installs are fixed on the next
  `docker compose up -d price-connector` regardless of the `PRICEROLE` in their
  `.env`. Ticker-only exchanges like Coinbase also require `COINBASEKEY`/
  `COINBASESECRET`. (Community thread 4872.)
- Documented the reliable manual fallback for upgrading **admin-sh** itself
  (`docker compose pull admin-sh && docker compose up -d --force-recreate
  admin-sh`) in `DEPLOYMENT.md`, the troubleshooting table, and the
  `COMPOSE_DIR_HOST_PATH` comment — for when self-upgrade is disabled or
  fails. Pairs with admin-sh ≥ 1.2.0 (clear self-upgrade errors + real
  success/failure) and frontend ≥ 2.23.0 (Admin → Updates surfaces it).

### Security

## [2.5.0] - 2026-07-01
### Added
- Updated **frontend** image from **2.14.0 ➜ 2.22.0** and **admin-sh** from **1.0.1 ➜ 1.1.0**: new **Admin → Diagnostics** page — per-exchange live price-feed liveness, Redis reachability, and service health. Flags enabled exchanges receiving no live data (the usual reason a simulated bot silently stops trading).
### Fixed
- Updated **paper-trading** image from **1.3.0 ➜ 1.3.2**: simulated (paper) orders on lower-activity exchanges like Coinbase could stop filling when busier markets updated at the same time — DCA buys/sells now place correctly again.
- Updated **exchange-connector** image from **1.7.0 ➜ 1.9.0** and **websocket-connector** from **1.9.3 ➜ 1.9.4**: authoritative asset class on Bybit/Kraken and per-account user-stream liveness handling.
- Updated **main-app** image from **1.20.0 ➜ 1.23.1**: normalized pair asset categories, per-exchange snapshots, funding-rate history, and REST-API multi-TP/SL UUID validation.

## [2.4.0] - 2026-06-22
### Changed
- Updated **frontend** image from **2.10.21 ➜ 2.14.0**. **Changed**: Backtest results, Backtester performance, Mark the app shell `noindex, nofollow`, Disable TradingView's built-in Google Analytics, Affiliate program; **Added**: Connect guide, Hedge bots options, Login & Security: Allowed Login Methods, Bot Webhooks section now has Incoming/Outgoing tabs, Funding rate; **Fixed**: Bot details, DIV indicator logic, Portfolio, Bot deals, Hyperliquid Add Exchange, Toast dismiss, Bot performance chart, Two-Factor Authentication, OAuth consent, Overview, Bot tables, New-bot page, Cloning a Combo or Grid bot now opens a pre-filled.
- Updated **main-app** image from **1.18.9 ➜ 1.20.0**. **Changed**: Reset user process; **Added**: Snapshots per exchange, Get funding rate history; **Fixed**: REST-API multi-TP/SL validation rejected every real UUID (compared uuid values against the key allowlist).
- Updated **exchange-connector** image from **1.6.1 ➜ 1.7.0**. **Added**: Get funding rate history.
- Updated **paper-trading** image from **1.2.3 ➜ 1.3.0**. **Added**: Get funding rate history.

## [2.3.5] - 2026-06-11
### Changed
- Updated **frontend** image from **2.10.21 ➜ 2.10.23**. **Fixed**: Backtester performance, DIV indicator logic.
- Updated **main-app** image from **1.18.7 ➜ 1.18.9**. **Fixed**: Backtester performance, DIV indicator logic.

## [2.3.4] - 2026-06-10
### Changed
- Updated **frontend** image from **2.10.10 ➜ 2.10.21**. **Fixed**: DOM exception, Bot error messages, Closed and canceled deals no longer report an unrealized P&L, New-bot page no longer gets stuck, Editing and saving a DCA, The bot-create "insufficient credits" guard, Closed/canceled deals, Deal lists, Existing stale deals/bots now actually clear on upgrade, Closing several deals in a row from the deals card, Combo bot "Total Profit", Global Variables, DCA overview, Backtest results; **Changed**: New-bot wizard, The Bots/Deals toggle; **Added**: Bot ID to bot tables, Bot detail drawer "DCA Analysis" .
- Updated **websocket-connector** image from **1.9.1 ➜ 1.9.3**. **Added**: User-stream extension seams, Binance connection race.
- Updated **main-app** image from **1.18.6 ➜ 1.18.7**. **Changed**: Enable gzip/deflate compression on all API responses.

## [2.3.3] - 2026-06-09
### Changed
- Updated **frontend** image from **2.10.7 ➜ 2.10.10**. **Fixed**: Toolbar action rows, Placing a Trading Terminal order, Adding or reducing funds.
- Updated **admin-sh** image from **1.0.0 ➜ 1.0.1**. **Fixed**: Express error handling middleware.
- Updated **main-app** image from **1.18.4 ➜ 1.18.6**. **Changed**: Error dictionary; **Fixed**: A manual add/reduce-funds failure on a deal.

## [2.3.2] - 2026-06-08
### Changed
- Updated **frontend** image from **2.7.10 ➜ 2.10.7**. **Changed**: Bot forms always start from default values, Capital-required popup; **Fixed**: DCA Bot Controller, Trading terminal, KuCoin spot candles, Grid bot edit page; **Added**: Trading Terminal "Exchange Orders" tab, Redesigned full-screen backtest results modal.
- Updated **exchange-connector** image from **1.5.2 ➜ 1.6.1**. **Fixed**: Bitget futures balance; **Added**: Kucoin hedge mode.
- Updated **main-app** image from **1.18.3 ➜ 1.18.4**. **Fixed**: Exchange disabled by host configuration for paper exchanges.
- Updated **websocket-connector** image from **1.8.0 ➜ 1.9.1**. **Fixed**: Bitget futures balance; **Added**: Hyperliquid IP rotation.

## [2.3.1] - 2026-06-03
### Changed
- Updated **frontend** image from **2.7.8 ➜ 2.7.10**. Fixed: Dynamic AR config; Added: Pair preset selector, Favorite (starred) pairs, persisted locally,  Fiat currency icons for 30 currencies.

## [2.3.0] - 2026-06-02
### Changed
- Updated **main-app** image from **1.18.0 ➜ 1.18.3**. Added: `getBotEvents`: optional `category` input, Expose `paperContext` on `dcaDeal`/`comboDeal` GraphQL types, Hyperliquid builder fees.
- Updated **exchange-connector** image from **1.5.0 ➜ 1.5.2**. Changed: Hyperliquid balance 422 error retry and log; Added: Hyperliquid builder fee.
- Updated **frontend** image from **2.6.0 ➜ 2.7.8**. Fixed: DCA deal usage, Base Order Size input, Combo/DCA deal lists ; Changed: Bot forms, Live stores hydration, DCA "Total Funds", Base order section, Error screen, Login page, Deal cards, Bot events; Added: isTrialAvailable, Top Deals widget, Cancel button, Hyperliquid builder fees.

## [2.2.0] - 2026-05-28
### Added
- **admin-sh service** powering the dashboard's new `/admin` page —
  start/stop/restart/logs for compose services, granular per-exchange
  enable/disable, and one-click image upgrades. Mounts the docker
  socket; scoped to the compose project via the
  `com.docker.compose.project` label. New env block in `.env.sample`:
  `ADMIN_PORT`, `ADMIN_CONFIG_ENABLED`, `COMPOSE_DIR_HOST_PATH`,
  `DOCKER_REGISTRY_*`, plus optional per-service `*_VERSION` pins.
- `ADMIN_CONFIG_ENABLED=true` added to `api`, `exchange-connector`,
  `user-update-connector`, and `price-connector` env blocks. These
  services now sync their enabled-exchanges set from Redis and react
  to operator changes without a recompose. Set `ADMIN_CONFIG_ENABLED=
  false` (or remove from your `.env`) to keep the legacy env-only
  behavior.
- `REDIS_HOST` / `REDIS_PASSWORD` added to `exchange-connector` env so
  it can join the same Redis bus for admin-config sync.
- `VITE_ADMIN_API_URL` added to `frontend` env so the dashboard's
  `/admin` page knows where to reach admin-sh.
- Bind mount of the docker-sh project directory into admin-sh at
  `/workspace`. Admin-sh creates `.versions.env` inside it on first
  upgrade — no manual `touch` needed. (Docker can't auto-create a
  single-file bind-mount target as a file, so we mount the parent dir
  instead.)

### Changed
- Switched all hardcoded image tags to `${X_VERSION:-<default>}`
  substitution so admin-sh's upgrade flow can pin new tags without
  editing the compose file:
  - `main-app:1.17.10` → `${MAIN_APP_VERSION:-1.18.0}`
  - `exchange-connector:1.4.3` → `${EXCHANGE_CONNECTOR_VERSION:-1.5.0}`
  - `websocket-connector:1.7.1` → `${WEBSOCKET_CONNECTOR_VERSION:-1.8.0}`
  - `paper-trading:1.2.3` → `${PAPER_TRADING_VERSION:-1.2.3}`
  - `frontend:2.5.1` → `${FRONTEND_VERSION:-2.5.1}`
- Updated **main-app** image default from **1.17.10 ➜ 1.18.0**.
  Added: `addExchange` GraphQL mutation refuses providers the operator
  disabled via the new Admin → Exchanges tab (sh-only — cloud
  unaffected).
- Updated **exchange-connector** image default from **1.4.3 ➜ 1.5.0**.
  Added: 503 guard on disabled exchanges driven by the admin-config
  Redis key (sh-only).
- Updated **websocket-connector** image default from **1.7.1 ➜ 1.8.0**.
  Added: per-variant filter inside subscribeCandleCb + diff-and-react
  worker lifecycle (newly-disabled families terminate; newly-enabled
  families spawn). userStream rejects new user-key subscribes for
  disabled exchanges and drops live streams on admin-config change.

## [2.1.0] - 2026-05-28
### Changed
- Updated **frontend** image from **2.4.2 ➜ 2.5.1**. Fixed: ComboBots stats, GridBots stats, DCA bot stats, Trading page stats aggregator, Trading page Total Profit no longer drops Grid bots' unrealized PnL, CoinSelect, DCA bot view dialog; Changed: VariableChip, EmptyState placement, DrawerDealsTable, Grid bot strategy settings; Added: Unified bot-list KPI strip, Hedge DCA / Hedge Combo bot list pages, IndicatorConfigurationModal / InlineIndicatorConfig, DetailDrawer body.
- Updated **main-app** image from **1.17.9 ➜ 1.17.10**. Changed: Enforce profitCurrency and orderFixedIn on server side for grid bot.

## [2.0.0] - 2026-05-27
### Changed
- **BREAKING**: Updated **frontend** image from **1.6.0 ➜ 2.4.2**. The image is now a Vite SPA served by nginx (was Next.js). If you've copied the previous compose, drop the `command:` override, the `NEXT_PUBLIC_SERVER` / `NEXT_PUBLIC_WS` env vars, and the `npm_config_*` flags — none apply to nginx. The `PORT` env var and `${PORT}:${PORT}` ports binding still work identically; nginx templates `${PORT}` into its config at start.
- Updated **exchange-connector** image from **1.3.2 ➜ 1.4.3**. Changed: Improve bitget get spot candles request, Hyperliquid request fills for limit orders; Fixed: Binance handle HTML 500 error, Hyperliquid not respect limits, Hyperliquid handle infinite loop, Hyperliquid asset index shift; Added: Hyperliquid HIP-3 support.
- Updated **main-app** image from **1.14.10 ➜ 1.17.9**. Changed: Return hyperliquid indicators, Runtime cache for all pairs, Bot messages index, Close deal by TP as Market order, Use max fee in tp order, Fee db index, Debug log to bot monitor, Set stats time after bot data converted, Long Wick logic, Indicator service to use indicators utils, Internal properties update in SSB, Indicator service closed only exchange, Control polling by ENV variable, Hyperliquid symbol precision, Not enough balance dictionary; Fixed: API v2: - Pagination wrong - Paper context check in info endpoints, Sell remainder false fired on deal start, Typo in sell remainder double check, Restore original state of deals from Redis, Change user name, Combo bot grid order size, Short combo minigrids size on high deviation, Kucoin intervals, Long Wick types, Move SL value got overwritten, Combo Base minigrid wrong step, Wrong start index for closed only stream, Avg lossing/winning/global deals duration, Scalar headers interceptor, Broker codes, Indicator duplicated candles; Added: Long Wick, Session, Mongo DB connection string support, Timer to release mutex, Polling for HL orders, Indicator state ednpoint, Adapters for parent features.
- Updated **websocket-connector** image from **1.4.1 ➜ 1.7.1**. Changed: Hyperliquid candles logic, Hyperliquid reconnection, Increase Hyperliquid timeouts, Hyperliquid pairs mapping, Binance spot stream, Rabbit and Mutex logic, Send only closed candles in Binance, OKX and Bybit, Hyperliquid max connections 10, Hyperliquid reconnection params; Fixed: Hyperliquid reconnection logic, Hyperliquid max connections, Hyperliquid reconnection, Handle Kraken execeptions, Kraken spot candles request, Binance new urls, Hyperliquid handle infinite loop, Hyperliquid do not send filled order updates if no fills, Kraken free asset, Improve balancer's load assignment; Added: Kucoin futures stream, Hyperliquid HIP-3 support, Hyperliquid balancer

## [1.7.2] - 2026-05-07
- Updated **paper-trading** image from **1.2.0 ➜ 1.2.3**. Changed: Remove hyperliquid name mapping,Connection string; Fixed: Crash on start

## [1.7.1] - 2026-04-09
- Updated **backtest** start script to fix volume ownership.

## [1.7.0] - 2026-03-13
- Updated **exchange-connector** image from **1.2.0 ➜ 1.3.2**. Changed: Added OKX host app.okx.com, Drop Kraken Coinm support; Fixed: Kraken Coinm base asset precision, Get Coinm candles request; Added: Kraken.
- Updated **paper-trading** image from **1.1.5 ➜ 1.2.0**. Fixed: Hyperliquid ticker processing issue; Added: Kraken.
- Updated **main-app** image from **1.10.2 ➜ 1.14.10**. Changed: Connect to user streams for active users, Enhanced log DCA by Market, Add listen flag for candles provider, Added OKX host app.okx.com, Added paperContext and bot status to related bots query, Increased max number of bots to return in related bots query, API v2, API v2 added createDCABot request, get global variables request, API v2 added createComboBot, createTerminalDeal, createGridBot requests, CRUD operations on global variables, Refactored API v2 endpoints, Split endpoint per bot type and deal type. Separate endpoints for terminal, Refactored .MD docs, extract schemas to a separate file, Moved paper context to a header, Kraken futures candles count, Hedge bots list for big account, Drop Kraken Coinm, Reduce bitget user stream connections; Fixed: Prevent duplicates in DCA by market orders, DCA by market errors not shown, Short required change calculation, OKX position size and order size, Terminal property in API handlers, API v2 bugs; Added: SSB API endpoints, Sync mode for SSB backtest, Kraken, Move SL trigger not respect fee, Connect child indicators with load1d flag, Kraken balance snapshot, Separate over and under limit not worked with dynamic price filter, Validation backtest endpoint, Discovery endpoints, API v2 keys options: paper context and bot id.
- Updated **websocket-connector** image from **1.2.0 ➜ 1.4.1**. Changed: Added OKX host app.okx.com, Debug hyperliquid fills, Drop support for legacy Binance keys, Drop Kraken Coinnm support; Fixed: Error stringify, Truncate keys; Added: Test connection, Kraken.
- Updated **frontend** image from **1.5.0 ➜ 1.6.2**. Changed: Show DCA by market in active deals, how cancel reduce funds orders in terminal; Fixed: Order not shown in deal, Short required change calculation, Prevent hedge big account double load, Variable inside array; Added: OKX source app, Kraken, API keys new options.

## [1.6.0] - 2026-01-28
### Changed
- Updated **frontend** image from **1.4.0 ➜ 1.5.0**. Fixed: Hedge bot page constantly rerender, Hedge table not showing bots, SL deal stop logic display, Hedge backtest render issue, Orphaned indicators after update, Big account hedge bot view; Changed: Backtester update, Hide Bybit nl, Supported resolution, Select only visible rows; Added: Separate max deal per over and under when using dynamic price filter, DCA by market.
- Updated **websocket-connector** image from **1.1.6 ➜ 1.2.0**. Fixed: Hyperliquid max order size; Added: Support Binance ED25519 keys, Websocket API for Spot user data streams. 
- Updated **main-app** image from **1.7.4 ➜ 1.10.2**. Fixed: Multi TP by Market caught duplicate order error, Multi SL not fired, TP section settings mixed up, Missed orders in search by status, Hyperliquid reposition partially filled order; Changed: GQL schema, Bot id in bot live stats; Added: DCA By Market, Separate max deal limits when using dynamic price filter over and under, Bot live stats. 
- Updated **exchange-connector** image from **1.1.19 ➜ 1.2.0**. Changed: Handle Binance Request throttled by system-level protection error, Workaround for Bybit EU pairs; Added: Support Binance ED25519 keys.

## [1.5.1] - 2026-01-06
### Changed
- Updated **main-app** image from **1.7.0 ➜ 1.7.4**. Fixed: Overwritten deal orders when updating deal, Missed indicator events if the same indicator is used in different sections; Changed: Exchange error dictionary, Broker codes with zone. 
- Updated **exchange-connector** image from **1.1.16 ➜ 1.1.19**. Changed: Bybit host, Hyperliquid retry count; Fixed: Bitget futures candles error.  

## [1.5.0] - 2025-12-25
### Added
- Password reset script
### Changed
- Updated **main-app** image from **1.6.6 ➜ 1.7.0**. Fixed: Profit by user/bot start date, Timezone offset, Skip balance check in move deal to terminal, AVP issue with group and section indicator logic, Check TP level wrong price; Changed: Improve random pair filtering, Combo breakeven calculation, Packages update; Added: Password reset

## [1.4.1] - 2025-11-11
### Changed
- Updated **main-app** image from **1.6.1 ➜ 1.6.6**. Fixed: Market TP order triggered at wrong price when having multiple deals, Hedge bot not found when stopped, API signature not valid with empty body; Changed: Demo user, Decorators apply logic in bot helpers. 
- Updated **websocket-connector** image from **1.1.5 ➜ 1.1.6**. Changed: Hyperliquid orders processing.  

## [1.4.0] - 2025-11-11
### Changed
- Updated **main-app** image from **1.5.2 ➜ 1.6.1**. Fixed: Use fixed base price in RR with fixed SL; Changed: Soft reset live account, Request candles for indicators through main thread; Added: Skip balance check option for Grid bots, Hyperliquid sub-account support. 
- Updated **exchange-connector** image from **1.1.13 ➜ 1.1.16**. Added: Hyperliquid sub-account support; Fixed: Hyperliquid sub-account requests without vault address, Bitget get candles request.  
- Updated **frontend** image from **1.3.0 ➜ 1.4.0**. Added: Hyperliquid Sub-account support, Skip balance check for grid bot, Fixed entry price in terminal deal with RR and fixed SL; Fixed: Paper Top-up asset, SL calculation in terminal deal edit component.  

## [1.3.0] - 2025-11-07
### Changed
- Updated **main-app** image from **1.4.22 ➜ 1.5.2**. Fixed: Max deal levels, Hedge Combo bot TP/SL base on value ignored; Added: Fixed Stop Loss in Risk Reward; Changed: Hyperliquid max candles. Hide hyperliquid in indicators. 
- Updated **exchange-connector** image from **1.1.12 ➜ 1.1.13**. Fixed: Hyperliquid queue.  
- Updated **websocket-connector** image from **1.1.4 ➜ 1.1.5**. Changed: Hyperliquid candle connect.
- Updated **frontend** image from **1.2.3 ➜ 1.3.0**. Added: Hyperliquid Web3 Auth, Risk:Reward with fixed stop loss, Expected absolute profit/loss in settings; Fixed: Hyperliquid spot chart stuck, Edit deal with RR in terminal, Paper hyperliuid add USDC asset.  

## [1.2.7] - 2025-11-04
### Changed
- Updated **main-app** image from **1.4.21 ➜ 1.4.22**. Fixed: Clone combo bot unsupported fields.  

## [1.2.6] - 2025-11-03
### Changed
- Updated **exchange-connector** image from **1.1.11 ➜ 1.1.12**. Added: Hyperliquid significant figures check.  
- Updated **main-app** image from **1.4.19 ➜ 1.4.21**. Fixed: Reset account with hedge bots, Handle worker terminate.  

## [1.2.5] - 2025-10-29
### Changed
- Updated **exchange-connector** image from **1.1.10 ➜ 1.1.11**. Changed: Hyperliquid retry get order amount.  
- Updated **main-app** image from **1.4.16 ➜ 1.4.19**. Fixed: Prevent duplicate transaction error, Deals filter in reset user method. Added: Close old start deals.  
- Updated **websocket-connector** image from **1.1.3 ➜ 1.1.4**. Changed: Bitget unique message id.
- Updated **frontend** image from **1.2.2 ➜ 1.2.3**. Fixed: Fair Value Gaps default values, Changing TP from indicators to other leave indicator, Hedge bot page display problems, Profit on dashboard in a different timezone. 

## [1.2.5] - 2025-10-27
### Changed
- Updated **exchange-connector** image from **1.1.9 ➜ 1.1.10**. Fixed: Hyperliquid futures balance.  
- Updated **main-app** image from **1.4.14 ➜ 1.4.16**. Fixed: Share Grid backtest input, Hyperliquid price precision. 

## [1.2.4] - 2025-10-24
### Changed
- Updated **exchange-connector** image from **1.1.8 ➜ 1.1.9**. Updated: Bybit coinm quote workaround. 
- Updated **main-app** image from **1.4.13 ➜ 1.4.14**. Fixed: Market TP wrong trigger when having SL and multicoin.  

## [1.2.3] - 2025-10-21
### Changed
- Updated **websocket-connector** image from **1.1.2 ➜ 1.1.3**. Fixed: Paper WS url.
- Updated **exchange-connector** image from **1.1.6 ➜ 1.1.8**. Updated: Coinbase retry count, Fixed: Bitget USDC product type.
- Updated **paper-trading** image from **1.1.4 ➜ 1.1.5**. Fixed: Type error.
- Updated **frontend** image from **1.2.1 ➜ 1.2.2**. Fixed: Duplicate Hedge bot. 
- Updated **main-app** image from **1.4.6 ➜ 1.4.13**. Updated: Backtester update, Mongo delete method, Hyperliquid USD rates. Added: Step parameter to update bot/deal API. Fixed: NOB order id, Move deal to terminal of multicoin bot, Reset trailing mode. 

## [1.2.2] - 2025-10-16
### Changed
- Updated **main-app** image from **1.4.2 ➜ 1.4.6**. Updated: Reduced unknown order retry count, Debug log for indicators, NOB logic for bot. Fixed: Clone combo bot input body, Server url in swagger. 
- Updated **paper-trading** image from **1.1.2 ➜ 1.1.4**. Fixed: Liquidation error, Subscribe to tickers. Channel name.
- Updated **exchange-connector** image from **1.1.5 ➜ 1.1.6**. Updated: Bitget limiter logic.

## [1.2.1] - 2025-10-10
### Changed
- Updated **frontend** image from **1.2.0 ➜ 1.2.1**. Fixed: Duplicate Hedge bot. 
- Updated **main-app** image from **1.4.1 ➜ 1.4.2**. Fixed: Multi SL issue. 

## [1.2.0] - 2025-10-09
### Changed
- Updated **frontend** image from **1.1.2 ➜ 1.2.0**. Added: Order Blocks & Fair Value Gaps (FVG only). Fixed: Coinbase candles update timer, Hedge bot create with TP market order. 
- Updated **main-app** image from **1.3.8 ➜ 1.4.1**. Added: Order Blocks & Fair Value Gaps (FVG only). Fixed: GQL input schema

## [1.1.5] - 2025-10-07
### Changed
- Updated **exchange-connector** image from **1.1.4 ➜ 1.1.5**. Changed: Hyperliquid price precision logic
- Updated **main-app** image from **1.3.6 ➜ 1.3.8**. Changed: Remove delisted pairs from the bot. Minor updates of inticator service logic

## [1.1.4] - 2025-10-06
### Changed
- Updated **frontend** image from **1.1.1 ➜ 1.1.2**. Fixed: Hyperliquid backtest data. Added: Market TP order
- Updated **exchange-connector** image from **1.1.3 ➜ 1.1.4**. Fixed: Hyperliquid get order retry
- Updated **paper-trading** image from **1.1.1 ➜ 1.1.2**. Fixed: x1 leverage short position liquidation price
- Updated **main-app** image from **1.3.2 ➜ 1.3.6**. Fixed: Market structure price actions, Reset not enough balance status, Hyperliquid spot order price precision. Added: Market TP order

## [1.1.3] - 2025-09-29
### Changed
- Hyperliquid fixes:
- Updated **websocket-connector** image from **1.1.1 ➜ 1.1.2**
- Updated **exchange-connector** image from **1.1.2 ➜ 1.1.3**
- Updated **main-app** image from **1.3.1 ➜ 1.3.2**

## [1.1.2] - 2025-09-26
### Changed
- Updated **exchange-connector** image from **1.1.1 ➜ 1.1.2**: Fixed hyperliquid all open orders response

## [1.1.1] - 2025-09-26
### Changed
- Hyperliquid fixes:
- Updated **websocket-connector** image from **1.1.0 ➜ 1.1.1**: user stream logic update
- Updated **exchange-connector** image from **1.1.0 ➜ 1.1.1**: order place logic update
- Updated **main-app** image from **1.3.0 ➜ 1.3.1**: set leverage/margin logic update
- Updated **frontend** image from **1.1.0 ➜ 1.1.1**: how to connect hyperliquid account

## [1.1.0] - 2025-09-25
### Changed
- Updated **exchange-connector** image from **1.0.13 ➜ 1.1.0**: Hyperliquid integration
- Updated **paper-trading** image from **1.0.7 ➜ 1.1.0**: Hyperliquid integration
- Updated **main-app** image from **1.1.3 ➜ 1.3.0**: Bug fixes, Hedge backtesting, Hyperliquid integration
- Updated **websocket-connector** image from **1.0.12 ➜ 1.1.0**: Hyperliquid integration
- Updated **frontend** image from **1.0.11 ➜ 1.1.0**: Bug fixes, Hedge backtesting, Hyperliquid integration

## [1.0.20] - 2025-09-19
### Changed
- Price connector environment variables

## [1.0.19] - 2025-09-18
### Changed
- Update of bitnami images: bitnami -> bitnamilegacy 

## [1.0.18] - 2025-09-17
### Changed
- Updated **websocket-connector** image from **1.0.10 ➜ 1.0.12**: Added list of supported exchange

## [1.0.17] - 2025-09-01
### Changed
- Updated **exchange-connector** image from **1.0.12 ➜ 1.0.13**: Bitget futures balance calculation

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
