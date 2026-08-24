#!/bin/bash
set -euo pipefail


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"

if incident_active; then
	
	echo "No active incident."

	exit 0
fi

load_incident

cat "$SCENARIO_DIR/$INCIDENT_ID/solution.md"
