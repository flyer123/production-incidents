#!/usr/bin/env bash

SERVICE="postgresql@16-main.service"
ENV_FILE="/opt/prod-lab/app/.env"
BACKUP_FILE="$BACKUP_DIR/007_db_password"

incident_backup() {

	sudo cp "$ENV_FILE"  "$BACKUP_FILE"

}

incident_inject() {

	sudo sed -i \
		's/^DB_PASSWORD=.*/DB_PASSWORD=INCORRECT_PASSWORD/' \
		"$ENV_FILE"

	sudo systemctl restart "$SERVICE"
	sudo systemctl restart prod-lab

}

incident_verify_injection() {

	if sudo grep -q '^DB_PASSWORD=INCORRECT_PASSWORD$' "$ENV_FILE"
	then
		return 0
	else
		return 1
	fi

}

incident_restore() {

	sudo cp "$BACKUP_FILE" "$ENV_FILE"
        sudo systemctl restart prod-lab

}

incident_ticket() {

    echo "========================================="
    echo "Incident 007"
    echo "========================================="
    echo
    echo "Priority: High"
    echo
    echo "User reports:"
    echo
    echo "Inventory information is unavailable."
    echo
    echo "The application is running, but database"
    echo "operations are failing."
    echo
    echo "Investigate and restore database connectivity."
    echo
    echo "Do not modify the PostgreSQL server configuration."
    echo

}

incident_validate_fix() {

	if curl -sf http://localhost/count > /dev/null
	then
		return 0
	else
		return 1
	fi

}
