# Red-Team Projects

Use this area for authorized offensive security work and controlled lab exercises.

## Project Folder Pattern

```text
red-team/
  project-name/
    scope.md
    recon.md
    testing-notes.md
    findings.md
    cleanup.md
```

## Workflow

1. Confirm authorization and scope.
2. Build an asset inventory from approved sources.
3. Prioritize tests by risk and allowed activity.
4. Capture evidence with timestamps and target identifiers.
5. Validate impact without unnecessary data access.
6. Document reproduction, impact, remediation, and cleanup.
7. Share defensive opportunities with the blue-team track.

## Starter Project Ideas

- Authorized web application assessment checklist.
- Bug bounty recon workflow with scope controls.
- Active Directory lab attack path mapping.
- Cloud IAM misconfiguration review.
- External exposure inventory for owned assets.

## Evidence Rules

- Store raw tool output in `evidence/red-team/`.
- Store polished findings in `reports/`.
- Redact tokens, cookies, API keys, emails, phone numbers, and personal identifiers before sharing.
