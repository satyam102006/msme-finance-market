#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: ./restore-data.sh <backup_directory>"
    echo "Available backups:"
    ls -la backups/ 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_DIR="$1"
if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ Backup directory not found: $BACKUP_DIR"
    exit 1
fi

cp -r "$BACKUP_DIR"/* storage/app/json/
echo "✅ Data restored from: $BACKUP_DIR"
