#!/bin/bash

# Define your project and Git repository paths
PROJECT_DIR="$HOME/rootInception"      # The directory where your Docker-related files are
GIT_REPO_DIR="$HOME/rootInceptionBackup"  # The directory where the Git repo is located for backup

# Set the backup directory
BACKUP_DIR="$HOME/rootInceptionBackup"

# Get current timestamp for the backup folder
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create a backup directory with the timestamp
mkdir -p "$BACKUP_DIR/$TIMESTAMP"

# Copy all the necessary files from your Docker project to the backup folder
cp -r "$PROJECT_DIR"/* "$BACKUP_DIR/$TIMESTAMP/"
cp "$HOME/backupInception.sh" "$BACKUP_DIR/$TIMESTAMP/"
cp -r "$HOME/env" "$BACKUP_DIR/$TIMESTAMP/"

# Navigate to the Git repository
cd "$GIT_REPO_DIR"

# Check if there are any changes in the backup directory
git add "$BACKUP_DIR/$TIMESTAMP/"

# Commit the changes to the backup Git repository
git commit -m "Backup of Docker files on $TIMESTAMP"

# Push the changes to the remote Git repository
git push origin main  # Replace 'main' with your default branch if it's different

# Optionally, you can log the backup to a file
echo "Backup of Docker files completed on $TIMESTAMP" >> "$BACKUP_DIR/backup_log.txt"

# Optional: Cleanup backups older than 7 days (adjust as necessary)
find "$BACKUP_DIR" -type d -mtime +30 -exec rm -rf {} \;

# Done!
echo "Backup completed and pushed to Git repository."
