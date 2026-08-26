#!/bin/bash

run_incident() {

	log "Starting incident lifecycle"

	info "Running precheck..."

	if ! run_optional_hook incident_precheck
	then
		fail "Precheck failed."
		log "Incident precheck failed"
		return 1
	fi

	log "Precheck complete"

	info "Backing up..."

	incident_backup

	log "Backup complete"

	info "Injecting incident..."

	incident_inject

	log "Incident injected"

	info "Verifying injection..."

	if incident_verify_injection
	then
		log "Injection verified"
	else
		fail "Injection verification failed"
		log "Injection verification failed"
		return 1

	fi

	save_incident_state

	log "Inciden state saved"

	echo

	incident_ticket

	log "Ticket displayed"


}

restore_incident() {
	
	log "Starting restore"

	load_incident || return 1

	load_plugin "$PLUGIN" || return 1

	validate_plugin || return 1

	if incident_restore
	then
	       	log "Restore complete"
	else
		fail "Incident restore failed"
		log "Incident restore failed"
		return 1
	fi
		

	rm -f "$CURRENT_INCIDENT"


	ok "Incident removed."

}

validate_repair() {

	load_incident || return 1

	load_plugin "$PLUGIN" || return 1

	validate_plugin || return 1

	if incident_validate_fix
	then

		ok "Repair verified."

		if ! run_optional_hook incident_cleanup
		then
			warn "Cleanup hook failed."
			log "Incident cleanup failed"
			return 1
		fi

		log "Incident cleanup complete"

		return 0

	fi
	warn "Repair verification failed."

	return 1

}



