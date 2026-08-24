#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {

cat <<EOF

Usage:

./run_incident.sh
    Run an incident

./run_incident.sh --list
    List incidents

./run_incident.sh --run ID
    Run a specific incident

./run_incident.sh --help
    Show this help

EOF

}

source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/config.sh"
source "$SCRIPT_DIR/lib/state.sh"
source "$SCRIPT_DIR/lib/ui.sh"
source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/incident_loader.sh"
source "$SCRIPT_DIR/lib/incident_manager.sh"
source "$SCRIPT_DIR/lib/framework.sh"

while [[ $# -gt 0 ]]
do
	case "$1" in
		--help)

			usage
			exit 0
			;;

		--list)

			list_incidents_pretty
			exit 0
			;;

		--run)

			shift

			select_incident_by_id "$1"

			;;

		*)

			fail "Unknown option: $1"

			usage

			exit 1

			;;

	esac

	shift

done

title "Production Incident Generator"

if incident_active
then
	warn "An incident is already active."
	exit 1
fi

source "$LIB_DIR/incident_manager.sh"

prepare_incident

load_plugin "$PLUGIN"

validate_plugin

run_incident
