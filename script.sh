#!/usr/bin/env bash

INTERVAL=10
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/monitor.log"

# Проверяем необходимые команды
for cmd in date free df uptime sleep; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: command '$cmd' not found" >&2
        exit 1
    fi
done

# Проверяем возможность записи в лог
if ! touch "$LOG_FILE"; then
    echo "Error: cannot write to $LOG_FILE" >&2
    exit 1
fi

# Корректное завершение по сигналу
trap 'echo "Monitoring stopped"; exit 0' INT TERM

echo "Monitoring started. Interval: ${INTERVAL}s"
echo "Log file: $LOG_FILE"

while true; do
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free -h
        df -h
        uptime
        echo
    } >> "$LOG_FILE" || {
        echo "Error: failed to write monitoring data" >&2
        exit 1
    }

    sleep "$INTERVAL"
done
