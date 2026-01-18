#!/bin/bash
set -e

# Configuration
CADDYFILE="/etc/caddy/Caddyfile"

TIGER_DATA_URL="${TIGER_DATA_URL}"

echo "🐯 Running Tiger Data migrations..."
cd /root/outray
if [ -n "$TIGER_DATA_URL" ]; then
  # Run migration files (not the full setup script which drops tables)
  for migration in deploy/migrations/*.sql; do
    if [ -f "$migration" ]; then
      echo "  Running $migration..."
      if ! psql "$TIGER_DATA_URL" -f "$migration"; then
        echo "❌ Failed to run migration: $migration" >&2
      fi
    fi
  done
  echo "✅ Tiger Data migrations complete."
else
  echo "⚠️ TIGER_DATA_URL not set, skipping migrations."
fi
