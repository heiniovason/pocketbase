#!/bin/sh
set -e

if [ -n "$PB_ADMIN_EMAIL" ] && [ -n "$PB_ADMIN_PASSWORD" ]; then
    echo "Creating superuser: $PB_ADMIN_EMAIL"
    /pb/pocketbase superuser upsert "$PB_ADMIN_EMAIL" "$PB_ADMIN_PASSWORD" --dir="$PB_DATA_DIR"
fi

echo "Starting PocketBase on $PB_HTTP_ADDR..."
exec /pb/pocketbase \
    --http="$PB_HTTP_ADDR" \
    --dir="$PB_DATA_DIR" \
    --publicDir="$PB_PUBLIC_DIR" \
    "$@"