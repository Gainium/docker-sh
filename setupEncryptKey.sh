#!/bin/bash

# Encryption Key Setup Helper for Gainium Self-Hosted
#
# Generates the per-installation ENCRYPT_KEY used to encrypt the exchange API
# credentials your users store, and writes it into the .env file next to this
# script. Safe to re-run: an existing key is never overwritten.
#
# Usage: ./setupEncryptKey.sh [path-to-env-file]
#
# The key MUST live in the host .env, which is what docker compose reads and
# passes to the containers. A key generated inside a container would be lost
# on the next `docker compose down` or image upgrade, and every credential
# encrypted under it would become permanently unreadable.

set -euo pipefail

ENV_FILE="${1:-$(cd "$(dirname "$0")" && pwd)/.env}"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ No .env file at: $ENV_FILE"
    echo "   Create it first:  cp .env.sample .env"
    exit 1
fi

# Match an assignment with a non-empty value, ignoring commented lines.
if grep -Eq '^[[:space:]]*ENCRYPT_KEY=.+' "$ENV_FILE"; then
    echo "✅ ENCRYPT_KEY is already set in $ENV_FILE — leaving it alone."
    echo ""
    echo "   Nothing else to do. If you have not backed this key up yet, do it"
    echo "   now: without it the stored exchange credentials cannot be read."
    exit 0
fi

if ! command -v openssl >/dev/null 2>&1; then
    echo "❌ openssl not found. Generate a key another way and add it manually:"
    echo "   ENCRYPT_KEY=<64 hex characters>"
    exit 1
fi

KEY="$(openssl rand -hex 32)"

# Replace an existing empty `ENCRYPT_KEY=` line if present (that is what
# .env.sample ships), otherwise append. Written via a temp file + mv so an
# interrupted run cannot leave a truncated .env behind.
TMP_FILE="$(mktemp "${ENV_FILE}.XXXXXX")"
trap 'rm -f "$TMP_FILE"' EXIT
cp "$ENV_FILE" "$TMP_FILE"

if grep -Eq '^[[:space:]]*ENCRYPT_KEY=[[:space:]]*$' "$ENV_FILE"; then
    # awk rather than sed -i: portable across GNU and BSD/macOS.
    awk -v key="$KEY" '
        /^[[:space:]]*ENCRYPT_KEY=[[:space:]]*$/ && !done { print "ENCRYPT_KEY=" key; done=1; next }
        { print }
    ' "$ENV_FILE" > "$TMP_FILE"
else
    printf '\n# Per-installation encryption key for stored exchange credentials.\n' >> "$TMP_FILE"
    printf '# Back this up. Losing it makes those credentials unrecoverable.\n' >> "$TMP_FILE"
    printf 'ENCRYPT_KEY=%s\n' "$KEY" >> "$TMP_FILE"
fi

# Keep the .env readable only by its owner — it now holds the master key.
chmod 600 "$TMP_FILE"
mv "$TMP_FILE" "$ENV_FILE"
trap - EXIT

echo "🔐 Generated a new ENCRYPT_KEY and wrote it to $ENV_FILE"
echo ""
echo "⚠️  Back up this file now, somewhere outside this host."
echo "    If the key is lost, the exchange API credentials stored in your"
echo "    database cannot be decrypted by anyone — including us — and every"
echo "    user has to re-enter their keys."
echo ""
echo "Next:"
echo "  • New installation — just start the stack:"
echo "        docker compose up -d"
echo "  • Existing installation — restart the services so they pick the key up,"
echo "    then re-encrypt what is already stored:"
echo "        docker compose up -d"
echo "        docker compose run --rm cli-runner npm run cli:rotate-encrypt-key -- --dry-run"
echo "        docker compose run --rm cli-runner npm run cli:rotate-encrypt-key"
echo ""
echo "    The backfill is safe to run with bots trading, and can be re-run if"
echo "    interrupted. See \"Encryption key\" in DEPLOYMENT.md."
