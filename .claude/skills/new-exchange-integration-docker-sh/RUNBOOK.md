# docker-sh — new exchange runbook

Canonical source: `new-exchange-integration` (private `skills` repo). This
is a scoped excerpt — see [SKILL.md](SKILL.md) for the narrative version.

## Where this sits

Repo **8, last, of the public pipeline** (exchange-connector-sh →
websocket-connector-sh → app-sh → paper-trading-sh → backtester →
main-dash-sh → content → **docker-sh**). Depends on every other public
repo already having shipped a version that supports this exchange — there's
nothing to do here until then. Only relevant if this exchange is going to
self-hosted at all.

## Checklist

```
[ ] docker-compose.yml    (bump pinned image versions: main-app, exchange-connector,
                            websocket-connector, paper-trading, dashboard)
[ ] .env.sample           (add exchange to PRICE_CONNECTOR_EXCHANGES default)
[ ] README                (update "Supported Exchanges" list)
```

## Verify before calling it done

- Spin up the bundle with these pins on a clean machine (or as close to one
  as practical) and confirm the exchange actually appears and works in the
  dashboard — a version-string bump with a typo'd tag is easy to miss until
  someone actually pulls it.
- Confirm `PRICE_CONNECTOR_EXCHANGES` really gates on the exchange's enum
  id string exactly as `websocket-connector-sh` expects it (case-sensitive
  match).
