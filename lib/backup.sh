#!/bin/bash

backup_file() {

SRC="$1"

DST="$BACKUP_DIR/$(basename "$SRC")"

sudo cp "$SRC" "$DST"

}

restore_file() {

FILE="$1"

SRC="$BACKUP_DIR/$(basename "$FILE")"

if [ -f "$SRC" ]
then

sudo cp "$SRC" "$FILE"

fi

}
