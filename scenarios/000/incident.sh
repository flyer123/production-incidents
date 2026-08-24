#!/usr/bin/env bash

incident_backup() {
	echo "inciden_backup()"
}

incident_inject() {
	echo "incident_inject()"
}

incident_verify_injection() {
	return 0
}

incident_restore() {
	echo "incident_restore()"
}

incident_ticket() {
	cat <<EOF
INC-000

Test incident.
EOF
}

incident_validate_fix() {
	return 0

}
