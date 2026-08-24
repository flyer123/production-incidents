#!/usr/bin/env bash


APP_LOG_DIR="/var/log/prod-lab"
LOGE_FILE="$APP_LOG_DIR/app.log"


BACKUP_FILE="$BACKUP_DIR/005_log_permissions"

incident_ticket() {

    echo "========================================="
    echo "Incident 005"
    echo "========================================="
    echo
    echo "Priority: Medium"
    echo
    echo "User reports:"
    echo
    echo "The application is not behaving normally."
    echo
    echo "Investigate and restore service."
    echo
    echo "Do not modify application code."

}

incident_backup() {

	stat -c '%a %U %G' "$APP_LOG_DIR" > "$BACKUP_FILE"

}

incident_inject() {

	sudo chmod 555 "$APP_LOG_DIR"

}

incident_verify_injection() {

	local MODE

	MODE=$(stat -c '%a' "$APP_LOG_DIR")

	if [ "$MODE" = "555" ]
	then
		return 0
	fi
	
	return 1

}

incident_validate_fix() {

	local MODE

	MODE=$(stat -c '%a' "$APP_LOG_DIR")

	if [ "$MODE" = "755" ]
	then
		if curl -sf http://localhost/health >/dev/null
		then
			return 0
		fi
	fi

	return 1

}

incident_restore() {

	local MODE
	local OWNER
	local GROUP

	read -r MODE OWNER GROUP < "$BACKUP_FILE"

	sudo chown "$OWNER:$GROUP" "$APP_LOG_DIR"
	sudo chmod "$MODE" "$APP_LOG_DIR"

}
