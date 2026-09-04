---
name: new-exchange-integration-docker-sh
description: This repo's slice of adding a brand-new exchange to Gainium — bumping the self-hosted release bundle to a version of every service that supports it, and enabling it by default. Self-hosted only; cloud deploys don't need this. Use when scoping or shipping a new-exchange self-hosted release in docker-sh.
---

# New exchange integration — docker-sh's part

Canonical source: `new-exchange-integration` in Gainium's internal `skills`
repo (private — this file is a scoped copy synced from there; edit the
source, not this copy, if it needs updating).

## Global objective

Gainium supports trading on multiple exchanges through a common internal
`Exchange` interface — one adapter per exchange so the rest of the platform
never has to know which exchange it's talking to. `docker-sh` is the
self-hosted release bundle: a `docker-compose.yml` pinning specific image
versions of every service, plus the env defaults a self-hoster starts from.
A new exchange only reaches self-hosted users once this repo's pins move
past the versions that added it.

## This repo's part

Comes **last**, and only matters if this exchange is shipping to
self-hosted at all (a quiet/alpha-only cloud launch might not, at least not
immediately):

- **`docker-compose.yml`** — bump the pinned image versions for every
  service that changed: the main-app image, the exchange-connector image,
  the websocket-connector image, the paper-trading image, and the dashboard
  image. All of them need to be at or past the version that added this
  exchange, or self-hosted runs a mismatched set (e.g. a dashboard that
  offers the exchange against a connector that doesn't support it yet).
- **`.env.sample`** — add the new exchange to the
  `PRICE_CONNECTOR_EXCHANGES` default list. This is the self-hosted
  allowlist gate — without it, the websocket connector never starts a
  worker for this exchange even though every image is up to date.
- **README** — update the "Supported Exchanges" list.

## Sister repos

All public, same repo family as this one:

- **exchange-connector-sh** — the adapter; the connector image this repo
  pins must be built from a commit at or after this repo's exchange-adding
  PR.
- **websocket-connector-sh** — the streams; same version-pinning
  requirement, and the source of the `PRICE_CONNECTOR_EXCHANGES` gate this
  repo's `.env.sample` sets.
- **app-sh** — the main-app image this repo pins.
- **paper-trading-sh** — the paper-trading image this repo pins.
- **main-dash-sh** — the dashboard image this repo pins.
- **backtester** — not shipped as its own image; already baked into the
  main-app and dashboard images this repo pins, at whatever version those
  services bumped to.
- **content** — the connect guide self-hosted users read the same as
  everyone else; nothing to pin here, just make sure it exists before
  advertising the exchange as supported.

Gainium's cloud SaaS wires a few more pieces on top of this stack
(paid-plan gating, an internal monitoring/admin layer, marketing pages) —
not part of the self-hosted deployment this repo ships, not this repo's
concern.
