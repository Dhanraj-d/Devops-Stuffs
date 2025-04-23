#!/bin/bash

# DB Connection
HOST="your-db-host.rds.amazonaws.com"
PORT="5432"
USER="your_db_user"
DB="postgres"
PASSWORD="your_password"

# Slack Webhook
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXXXXXXX/XXXXXXXX/XXXXXXXXXXXX"

# WAL threshold in bytes (4GB)
THRESHOLD=$((4 * 1024 * 1024 * 1024))

# Run the WAL diff query
export PGPASSWORD=$PASSWORD
result=$(psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DB" -Atc "
SELECT slot_name,
       pg_wal_lsn_diff(pg_current_wal_lsn(), restart_lsn) AS wal_lag_bytes
FROM pg_replication_slots
WHERE restart_lsn IS NOT NULL;
")

while IFS="|" read -r slot wal_lag; do
  if [ "$wal_lag" -gt "$THRESHOLD" ]; then
    curl -X POST -H 'Content-type: application/json' \
      --data "{\"text\":\"🚨 WAL lag alert: Slot *$slot* has exceeded 4GB. Current lag: $(numfmt --to=iec $wal_lag).\"}" \
      "$SLACK_WEBHOOK_URL"
  fi
done <<< "$result"
