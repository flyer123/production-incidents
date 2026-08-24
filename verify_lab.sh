#!/bin/bash


set -euo pipefail

source lib/common.sh
source lib/ui.sh
source lib/state.sh
source lib/incident_loader.sh
source lib/framework.sh
source lib/logger.sh

title "Verification"

if ! load_incident
then
	fail "No active incident."
	exit 1
fi


if ! load_plugin "$PLUGIN"
then 
	fail "Failed to load incident plugin."
	exit 1
fi


if ! validate_plugin
then
	fail "Plugin validation failed."
	exit 1
fi

info "Active incident: $INCIDENT_ID"
info "Validating fix..."

if incident_validate_fix
then
	ok "Incident fixed."
	log "Incident validation passed."
	exit 0
else
	fail "Incident is still present."
	log "Incident validation failed."
	exit 1
fi


