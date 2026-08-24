#!/bin/usr/env bash

SERVICE="postgresql@16-main.service"

incident_backup() {

	:

}

incident_inject() {

	sudo systemctl stop "$SERVICE"

}

incident_verify_injection() {

	if systemctl is-active --quiet "$SERVICE"
	then
		return 1
	else
		return 0
	fi

}

incident_restore() {

	sudo systemctl start "$SERVICE"

}

incident_ticket() {

    echo "========================================="
    echo "Incident 006"
    echo "========================================="
    echo
    echo "Priority: High"
    echo
    echo "User reports:"
    echo
    echo "Inventory information is unavailable."
    echo
    echo "The application is running, but database-dependent"
    echo "operations are failing."
    echo
    echo "Investigate and restore database connectivity."
    echo
    echo "Do not modify application code."

}

incident_validate_fix() {

    if systemctl is-active --quiet "$SERVICE"
    then
        return 0
    else
        return 1
    fi

}
