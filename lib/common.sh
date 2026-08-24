#!/bin/bash

BASE_DIR="$HOME/production-incidents"

LIB_DIR="$BASE_DIR/lib"

STATE_DIR="$BASE_DIR/state"

BACKUP_DIR="$BASE_DIR/backups"

SCENARIO_DIR="$BASE_DIR/scenarios"

LOG_DIR="$BASE_DIR/logs"

CURRENT_INCIDENT="$STATE_DIR/current"

METADATA="$STATE_DIR/metadata"

mkdir -p "$STATE_DIR"
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"
