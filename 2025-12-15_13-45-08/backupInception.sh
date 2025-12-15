#!/bin/bash

PROJECT_DIR="$HOME/rootInception"      
GIT_REPO_DIR="$HOME/rootInceptionBackup" 

BACKUP_DIR="$HOME/rootInceptionBackup"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

mkdir -p "$BACKUP_DIR/$TIMESTAMP"

cp -r "$PROJECT_DIR"/* "$BACKUP_DIR/$TIMESTAMP/"
cp "$HOME/backupInception.sh" "$BACKUP_DIR/$TIMESTAMP/"
cp -r "$HOME/env" "$BACKUP_DIR/$TIMESTAMP/"

cd "$GIT_REPO_DIR"

git add "$BACKUP_DIR/$TIMESTAMP/"

git commit -m "Backup of Docker files on $TIMESTAMP"

git push origin main  

echo "Backup of Docker files completed on $TIMESTAMP" >> "$BACKUP_DIR/backup_log.txt"

find "$BACKUP_DIR" -type d -mtime +30 -exec rm -rf {} \;

echo "Backup completed and pushed to Git repository."
