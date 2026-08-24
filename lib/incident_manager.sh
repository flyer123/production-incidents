#!/usr/bin/env bash

list_incidents() {

    find "$SCENARIO_DIR" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        -printf "%f\n" \
        | sort

}

select_incident() {

	list_incidents | head -1

}

load_metadata() {

	source "$SCENARIO_DIR/$1/metadata"

}

save_incident_state() {

cat > "$CURRENT_INCIDENT" <<EOF
INCIDENT_ID=$INCIDENT_ID
INCIDENT_NAME="$INCIDENT_NAME"
INCIDENT_CATEGORY="$INCIDENT_CATEGORY"
INCIDENT_DIFFICULTY=$INCIDENT_DIFFICULTY
INCIDENT_ESTIMATED_TIME=$INCIDENT_ESTIMATED_TIME
STATUS=ACTIVE
DATE="$(date '+%F %T')"
EOF

}

prepare_incident() {

    if [ -z "${PLUGIN:-}" ]
    then
        PLUGIN=$(select_incident)
    fi

    load_metadata "$PLUGIN"

}

list_incidents_pretty() {

	local incident_id

	while read -r incident_id
	do
		load_metadata "$incident_id"

		printf "%-5s %s\n" \
                    "$INCIDENT_ID" \
                    "$INCIDENT_NAME"

	done < <(list_incidents)

}

select_incident_by_id() {

	local incident_id="$1"

	if [ ! -d "$SCENARIO_DIR/$incident_id" ]
	then
		fail "Incident $INCIDENT_ID does not exists."

	fi

	PLUGIN="$incident_id"

}
