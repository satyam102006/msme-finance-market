#!/bin/bash
BACKUP_DIR="backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp -r storage/app/json/* "$BACKUP_DIR/"
echo "✅ Data backed up to: $BACKUP_DIR"
