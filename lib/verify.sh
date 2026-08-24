#!/bin/bash

check_service() {

systemctl is-active --quiet "$1"

}
