![Version](https://img.shields.io/badge/version-v1.2.0-blue)
# Production Incident Generator

A Linux production troubleshooting laboratory built with Bash.

## Features

- Plugin-based incident framework
- Repeatable scenarios
- Automatic backup and restore
- Repair verification
- Stateful incident lifecycle

## Incidents

| ID | Scenario |
|----|----------|
|001|Nginx stopped|
|002|Gunicorn stopped|
|003|Wrong upstream port|
|004|Disk space exhaustion|
|005|Log permission denied|
|006|PostgreSQL stopped|
|007|PostgreSQL authentication failure|

## Usage

```bash
./run_incident.sh --list
./run_incident.sh --run 003
./verify_lab.sh
./reset_lab.sh
```

## Releases

- **v1.2.0** — Initial public release with Incidents 001–008.
- **v1.2.1** — Added optional plugin lifecycle hooks.
