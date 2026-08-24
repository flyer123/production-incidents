#!/usr/bin/bash

SERVICE="prod-lab"

incident_ticket() {

    echo "========================================="
    echo "Incident 002"
    echo "========================================="
    echo
    echo "Priority: Medium"
    echo
    echo "User reports:"
    echo
    echo "The website is unavailable."
    echo
    echo "Investigate and restore service."
    echo
    echo "Do not modify application code."

}

incident_backup() {

	systemctl is-active "$SERVICE" > "$BACKUP_DIR/002_service_state"

}

incident_inject() {

	sudo systemctl stop "$SERVICE"

}

incident_verify_injection() {

	if systemctl is-active --quiet "$SERVICE"
	then
		return 1
	fi

	return 0
}

incident_validate_fix() {

	if systemctl is-active --quiet "$SERVICE"
	then
		return 0
	fi
	
	return 0
}

incident_restore() {

	systemctl start "$SERVICE"

}

