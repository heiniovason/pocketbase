#!/bin/sh
set -e

PB_SUPERUSER_CREATED="$PB_DATA_DIR/.superuser_created"

if [ -n "$PB_ADMIN_EMAIL" ] && [ -n "$PB_ADMIN_PASSWORD" ]; then
    if [ ! -f "$PB_SUPERUSER_CREATED" ]; then
        echo "Initial boot — creating superuser: $PB_ADMIN_EMAIL"
        /pb/pocketbase superuser upsert "$PB_ADMIN_EMAIL" "$PB_ADMIN_PASSWORD" --dir="$PB_DATA_DIR"
        echo "$(date -Iseconds) $PB_ADMIN_EMAIL" > "$PB_SUPERUSER_CREATED"
    else
        echo "Superuser already bootstrapped — skipping."
    fi
fi

echo "Starting PocketBase on $PB_HTTP_ADDR..."
exec /pb/pocketbase \
    --http="$PB_HTTP_ADDR" \
    --dir="$PB_DATA_DIR" \
    --publicDir="$PB_PUBLIC_DIR" \
    "$@"
