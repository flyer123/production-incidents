#!/bin/bash

SERVICE="nginx"

BACKUP_STATE="$SCRIPT_DIR/backups/001/nginx_state"

incident_backup() {

	mkdir -p "$(dirname "$BACKUP_STATE")"

	systemctl status "$SERVICE" | grep Active: | awk '{print $2}' > "$BACKUP_STATE"

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

incident_validate_fix() {

	if systemctl is-active --quiet "$SERVICE"
	then
		if curl -s -f http://localhost
		then
			return 0
		else
			return 1
		fi
	else
		return 1
	fi

}

incident_restore() {

	original_state=$(cat "$BACKUP_STATE")


	if [ "$original_state"="active" ]

	then
		sudo systemctl start "$SERVICE"

		rm -r  "$SCRIPT_DIR/backups/001/"

	elif [ "$original_state"="inactive" ]
	
	then
		sudo systemctl stop "$SERVICE"

		rm -r  "$SCRIPT_DIR/backups/001/"
	else
		echo "Error, no original state"
	fi


}

incident_ticket() {

	echo "========================================="
	echo "Incident 001"
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
