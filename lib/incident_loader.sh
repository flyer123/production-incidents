#!/usr/bin/env bash

load_plugin() {
	local PLUGIN="$1"

	local FILE="$SCENARIO_DIR/$PLUGIN/incident.sh"

	if [ ! -f "$FILE" ] ;then
		echo "Plugin not found: $PLUGIN"
		return 1
	fi

	source "$FILE"
}

validate_plugin() {

	local REQUIRED=(
	    incident_backup
	    incident_inject
	    incident_verify_injection
	    incident_restore
	    incident_ticket
	    incident_validate_fix
    )

    for FUNC in "${REQUIRED[@]}"; do
	    if ! declare -F "$FUNC" >/dev/null; then
		    echo "Plugin missing function: $FUNC"
		    return 1
	    fi
    done
}

run_optional_hook() {

	local FUNC="$1"

	if declare -F "$FUNC" >/dev/null
	then
		"$FUNC"
	fi

}
