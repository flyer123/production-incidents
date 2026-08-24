#!/usr/bin/env bash

ROLE="prod_lab"
BACKUP_FILE="$BACKUP_DIR/008_connection_limit"

incident_backup() {

	sudo -u postgres psql -At \
		-c "SELECT rolconnlimit FROM pg_roles WHERE rolname='$ROLE';" \
		> "$BACKUP_FILE"

}

incident_inject() {

	sudo -u postgres psql \
		-c "ALTER ROLE $ROLE CONNECTION LIMIT 0;"
	
}

incident_verify_injection() {

	local LIMIT

	LIMIT=$(
	    sudo -u postgres psql -At \
		    -c "SELECT rolconnlimit FROM pg_roles WHERE rolname='$ROLE';"
	    )

	    [ "$LIMIT" = "0" ]

}

incident_restore() {

	local LIMIT

	LIMIT=$(cat "$BACKUP_FILE")

	sudo -u postgres psql \
		-c "ALTER ROLE $ROLE CONNECTION LIMIT $LIMIT;"

}

incident_ticket() {

    cat <<EOF
=========================================
Incident 008
=========================================

Priority: High

User reports:

Inventory information is unavailable.

The application is responding,
but database operations fail intermittently.

Investigate and restore database connectivity.

Do not restart PostgreSQL unless evidence requires it.
EOF

}

incident_validate_fix() {

	curl -sf http://localhost/count >/dev/null

}


