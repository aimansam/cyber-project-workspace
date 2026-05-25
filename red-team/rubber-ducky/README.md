# Rubber Ducky Red-Team Project

Purpose: plan and document authorized USB HID security testing using Rubber Ducky-style techniques in a controlled lab or explicitly approved engagement.

This project must stay scoped to systems you own, lab hosts, or targets where written authorization allows USB HID testing. Do not test on public, workplace, client, or third-party devices without explicit approval.

## Project Goals

- Understand USB HID attack paths and user-risk scenarios.
- Build a harmless baseline test that proves keyboard injection risk without damaging systems.
- Document defensive controls for blocking, detecting, and responding to rogue HID activity.
- Produce sanitized evidence and a report-ready finding template.

## Folder Map

```text
red-team/rubber-ducky/
  README.md
  scope.md
  testing-notes.md
  findings.md
  cleanup.md
  payloads/
    README.md
```

## Milestones

1. Complete `scope.md` before testing.
2. Prepare one isolated lab machine and confirm snapshots/backups.
3. Run only the harmless baseline payload first.
4. Capture screenshots, timestamps, device identifiers, and system logs.
5. Convert observations into blue-team detection and hardening notes.
6. Write findings and cleanup status.

## Defensive Questions

- Does the endpoint allow new USB keyboard devices by default?
- Are new HID devices logged with useful details?
- Can endpoint controls block unknown USB devices?
- Can the SIEM alert on suspicious HID timing or device insertion events?
- Are users trained to report unknown USB devices?
