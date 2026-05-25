# Payloads

Use this folder for authorized lab-only HID payload notes.

Start with harmless payloads that demonstrate keyboard injection risk without running commands, collecting data, changing settings, or creating persistence.

## Safe Baseline Payload Behavior

- Types a short lab message into an already-open text editor.
- Does not open terminals, browsers, settings, or system tools.
- Does not access files, credentials, network resources, or clipboard data.
- Does not disable controls or alter configuration.

## Payload Review Checklist

- [ ] Scope allows USB HID testing.
- [ ] Target is owned or explicitly authorized.
- [ ] Payload has been reviewed before execution.
- [ ] Payload does not collect secrets or personal data.
- [ ] Payload does not persist or change system settings.
- [ ] Cleanup and evidence handling are documented.
