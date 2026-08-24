#!/bin/bash

load_incident() {

    if [ ! -f "$CURRENT_INCIDENT" ]; then
        return 1
    fi

    source "$CURRENT_INCIDENT"

    if [ -z "${INCIDENT_ID:-}" ]; then
        fail "Incident state is corrupted."
        return 1
    fi

    PLUGIN="$INCIDENT_ID"

    return 0
}

incident_active() {

    [ -f "$CURRENT_INCIDENT" ]
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
