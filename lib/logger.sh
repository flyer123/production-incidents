#!/usr/bin/env bash

log() {
    local MESSAGE="$1"

    echo "$(date '+%F %T') $MESSAGE" >> "$LOG_DIR/framework.log"
}
