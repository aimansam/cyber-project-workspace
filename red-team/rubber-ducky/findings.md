# Findings

Use this file for sanitized findings from lab or authorized testing.

## Finding Template

### Title

Unknown USB HID Device Accepted by Endpoint

### Severity

To be determined based on scope, controls, and business impact.

### Affected Asset

- Host:
- User context:
- Device:

### Summary

The test system accepted a new USB HID keyboard device and allowed it to type input into the active user session.

### Evidence

- Timestamp:
- Screenshot/log path:
- Device identifier:

### Impact

An attacker with physical access may be able to inject keystrokes into an unlocked session. Actual impact depends on endpoint controls, user privileges, session state, and monitoring coverage.

### Remediation

- Enforce USB device-control policies.
- Require approval for new HID devices on sensitive endpoints.
- Lock sessions when unattended.
- Monitor new HID device insertion events.
- Train users to report unknown USB devices.

### Validation

- Retest date:
- Control verified:
- Remaining risk:
