# Cybersecurity Project Workspace

Purpose: organize authorized cybersecurity projects across red-team testing, blue-team detection, lab operations, and reporting.

This workspace is designed for legal, permission-based work only. Keep each engagement tied to written scope, explicit authorization, and clear rules of engagement before running scans, payloads, phishing simulations, exploitation, or monitoring activity.

## Workspace Map

```text
cyber-project-workspace/
  docs/                 Planning, scope, lab design, and operating notes
  blog/                 Public-safe writeups, drafts, and post templates
  assets/images/        Diagrams, screenshots cleared for sharing, and blog images
  project/red-team/     Authorized offensive projects, each as its own repo
  project/blue-team/    Defensive projects, each as its own repo when needed
  shared/               Shared assets, inventories, data schemas, and references
  evidence/             Screenshots, logs, exports, packet captures, and raw findings
  reports/              Draft and final reports
  scripts/              Helper scripts and automation
  tools/                Tool notes, wrappers, configs, and local integrations
```

## Suggested Project Tracks

### Red Team

- Recon and asset inventory for approved targets
- Web application testing playbooks
- Network service assessment workflow
- Active Directory lab exercises
- Cloud security assessment notes
- Social engineering simulation planning, only with explicit written approval
- Post-assessment evidence cleanup checklist

### Blue Team

- SIEM/lab log ingestion pipeline
- Detection engineering rule library
- Incident response tabletop scenarios
- Threat hunting notebooks and queries
- Endpoint telemetry collection notes
- Vulnerability management workflow
- Purple-team validation of red-team findings

### Shared

- Asset inventory format
- Finding severity rubric
- Evidence naming convention
- Rules of engagement templates
- Report templates
- Lab network diagram and service inventory

### Blog and Images

- Public-safe technical writeups
- Case-study drafts from lab or authorized work
- Sanitized diagrams and screenshots
- Blog image inventory and attribution notes
- Redaction checklist before publishing

## Operating Rhythm

1. Define scope in `docs/rules-of-engagement.md`.
2. Create a standalone project repo under `project/red-team/` or `project/blue-team/`.
3. Record assumptions, targets, credentials handling notes, and test windows before action.
4. Store raw outputs in `evidence/` and sanitized summaries in `reports/`.
5. Convert useful defensive learnings into detections, queries, or hardening tasks.
6. Turn safe lessons into blog drafts when useful.
7. Review artifacts for secrets, personal data, and out-of-scope details before sharing.

## Safety Baseline

- Work only on systems where you have permission.
- Keep credentials, tokens, cookies, customer data, and personal identifiers out of reports unless absolutely required and approved.
- Prefer lab replicas for exploit development or destructive testing.
- Rate-limit scanning and avoid tests that could affect availability unless approved.
- Keep a clear activity log for every engagement.

## Standalone Project Repos

The workspace repo tracks shared structure, docs, and automation. Individual project folders are ignored by the workspace repo so they can each have their own GitHub repository.

Use the all-in-one menu for common actions:

```bash
./menu.sh
```

Create a new red-team project with:

```bash
./scripts/create-red-team-project.sh "Project Name"
```

Create a new blue-team project with:

```bash
./scripts/create-blue-team-project.sh "Project Name"
```

Or create a project and push it to a dedicated GitHub repo:

```bash
./scripts/create-red-team-project.sh "Project Name" https://github.com/USER/PROJECT.git
./scripts/create-blue-team-project.sh "Project Name" https://github.com/USER/PROJECT.git
```
