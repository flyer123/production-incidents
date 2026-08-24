#!/bin/bash


INCIDENT_DIR="/tmp/prod-lab-incident-004"
FILL_FILE="$INCIDENT_DIR/disk_fill"

incident_ticket() {

    echo "========================================="
    echo "Incident 004"
    echo "========================================="
    echo
    echo "Priority: Medium"
    echo
    echo "User reports:"
    echo
    echo "The website is responding slowly or intermittently."
    echo
    echo "Investigate and restore service."
    echo
    echo "Do not modify application code."

}

incident_backup() {

	mkdir -p "$INCIDENT_DIR"

}

incident_inject() {

	local AVAILABLE_KB
	local TARGET_KB
	local TARGET_MB

	AVAILABLE_KB=$(df --output=avail / | tail -1)

	TARGET_KB=$((AVAILABLE_KB - 1048576))

	if [ "$TARGET_KB" -le 0 ]
	then
		echo "Not enough free space to safely create incident."
		return 1
	fi

	TARGET_MB=$((TARGET_KB / 1024))

	dd if=/dev/zero \
	   of="$FILL_FILE" \
	   bs=1M \
	   count="$TARGET_MB" \
	   status=none

}

incident_verify_injection() {

	local USE_PERCENT

	USE_PERCENT=$(df --output=pcent / | tail -1 | tr -d ' %')
	
	
	if [ -f "$FILL_FILE" ] && [ "$USE_PERCENT" -ge 80 ]
	then
		return 0
	fi

	return 1

}

incident_validate_fix() {

	if [ ! -f "$FILL_FILE" ]
	then
		if curl -sf http://localhost/health >/dev/null
		then
			return 0
		fi
	fi

	return 1

}

incident_restore() {

	rm -rf "$INCIDENT_DIR"

}

