#!/bin/bash
set -e

# Cek apakah tabel sudah ada
if ! psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "\dt pesanan" | grep -q pesanan; then
    echo "Initializing database..."
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/init.sql
else
    echo "Database already initialized, skipping init script"
fi