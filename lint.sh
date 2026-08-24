#!/usr/bin/env bash
set -e

echo "Checking framework..."

find . -name "*.sh" | while read -r file
do
	bash -n "$file"
	echo "OK $file"
done

echo
echo "Framework syntax passed."
