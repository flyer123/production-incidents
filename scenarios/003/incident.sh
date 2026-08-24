#!/bin/bash

NGINX_CONFIG="/etc/nginx/sites-available/prod-lab"
BACKUP_FILE="$BACKUP_DIR/003_nginx_config"

incident_ticket() {

    echo "========================================="
    echo "Incident 003"
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

incident_backup() {

	cp "$NGINX_CONFIG" "$BACKUP_FILE"

}

incident_inject() {

	sudo sed -i 's/proxy_pass http:\/\/127.0.0.1:[0-9]*/proxy_pass http:\/\/127.0.0.1:5999/' "$NGINX_CONFIG"

	sudo nginx -t
	sudo systemctl reload nginx

}

incident_verify_injection() {

	if grep -q "127.0.0.1:5999" "$NGINX_CONFIG"
	then
		return 0
	fi

	return 1

}

incident_validate_fix() {

	sudo nginx -t || return 1

	if curl -sf http://localhost/ >/dev/null
	then
		return 0
	fi

	return 1

}

incident_restore() {

	sudo cp "$BACKUP_FILE" "$NGINX_CONFIG"

	sudo nginx -t || return 1

	sudo systemctl reload nginx

}
