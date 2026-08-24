Cause

The nginx service was stopped.

Diagnosis

systemctl status nginx

Fix

sudo systemctl start nginx

Verification

curl http://localhost

Prevention

Enable monitoring for nginx service health.
