# Plugin API

Every incident plugin must implement six functions.

## Required functions

```bash
incident_backup()
incident_inject()
incident_verify_injection()
incident_restore()
incident_ticket()
incident_validate_fix()
```

## Lifecycle

backup
↓
inject
↓
verify injection
↓
save state
↓
investigation
↓
repair
↓
validate_fix
↓
restore

## Optional hooks

Plugins may additionally implement:

```bash
incident_precheck()
incident_cleanup()
