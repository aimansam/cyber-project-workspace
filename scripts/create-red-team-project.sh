#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  printf 'Usage: %s "Project Name" [github-remote-url]\n' "$0" >&2
  exit 1
fi

project_name="$1"
remote_url="${2:-}"
workspace_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

slug="$(printf '%s' "$project_name" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"

if [[ -z "$slug" ]]; then
  printf 'Project name must contain at least one letter or number.\n' >&2
  exit 1
fi

project_dir="$workspace_root/red-team/$slug"

if [[ -e "$project_dir" ]]; then
  printf 'Project already exists: %s\n' "$project_dir" >&2
  exit 1
fi

mkdir -p "$project_dir/payloads" "$project_dir/evidence" "$project_dir/reports"

cat > "$project_dir/README.md" <<EOF_PROJECT_README
# $project_name Red-Team Project

Purpose: document authorized red-team work for this project.

This project is an independent Git repository inside the larger cybersecurity workspace. Keep scope, evidence, findings, and reports inside this project folder so it can be pushed to its own GitHub repository.

## Folder Map

\`\`\`text
$slug/
  README.md
  scope.md
  testing-notes.md
  findings.md
  cleanup.md
  payloads/
  evidence/
  reports/
\`\`\`

## Milestones

1. Complete \`scope.md\` before testing.
2. Confirm authorization and test windows.
3. Run only approved tests.
4. Store evidence under \`evidence/\`.
5. Write sanitized findings and reports.
6. Complete cleanup notes.

## Safety Baseline

- Work only on systems where testing is authorized.
- Do not collect secrets, tokens, cookies, or personal data.
- Stop if scope or authorization is unclear.
EOF_PROJECT_README

cat > "$project_dir/scope.md" <<EOF_SCOPE
# Scope

## Authorization

- Project: $project_name
- Operator:
- Authorization source:
- Start date:
- End date:

## In Scope

- Targets:
- Test accounts:
- Allowed test windows:
- Allowed techniques:

## Out of Scope

- Third-party systems without written approval
- Destructive testing
- Credential theft
- Persistence
- Data exfiltration

## Stop Conditions

- Authorization is unclear.
- Target is outside scope.
- Testing may affect availability or data integrity.
- Sensitive data appears in output.

## Activity Log

| Date/Time | Operator | Action | Target | Result | Evidence |
| --- | --- | --- | --- | --- | --- |
EOF_SCOPE

cat > "$project_dir/testing-notes.md" <<'EOF_TESTING'
# Testing Notes

## Preparation

- Confirm written authorization and scope.
- Confirm target ownership and test windows.
- Prepare evidence folders.
- Start any required logging or monitoring.

## Notes

| Date/Time | Test | Target | Result | Evidence |
| --- | --- | --- | --- | --- |
EOF_TESTING

cat > "$project_dir/findings.md" <<'EOF_FINDINGS'
# Findings

## Finding Template

### Title

### Severity

### Affected Asset

### Summary

### Evidence

### Impact

### Remediation

### Validation
EOF_FINDINGS

cat > "$project_dir/cleanup.md" <<'EOF_CLEANUP'
# Cleanup

- [ ] Removed test artifacts from targets.
- [ ] Stored only approved evidence.
- [ ] Redacted sensitive values before sharing.
- [ ] Recorded final target state.
- [ ] Captured lessons learned.
EOF_CLEANUP

cat > "$project_dir/payloads/README.md" <<'EOF_PAYLOADS'
# Payloads

Use this folder only for authorized lab or engagement payload notes.

## Review Checklist

- [ ] Scope allows this test.
- [ ] Target is owned or explicitly authorized.
- [ ] Payload does not collect secrets or personal data.
- [ ] Payload does not persist or change system settings unless approved.
- [ ] Cleanup is documented.
EOF_PAYLOADS

cat > "$project_dir/evidence/README.md" <<'EOF_EVIDENCE'
# Evidence

Store raw evidence for this project here.

Do not commit secrets, tokens, cookies, API keys, private personal data, or unapproved customer information.
EOF_EVIDENCE

cat > "$project_dir/reports/report.md" <<EOF_REPORT
# $project_name Report

Status: Draft

## Executive Summary

## Scope

## Test Summary

| Test | Target | Result | Evidence |
| --- | --- | --- | --- |

## Findings

## Recommendations

## Cleanup Status
EOF_REPORT

cat > "$project_dir/.gitignore" <<'EOF_PROJECT_GITIGNORE'
.env
.env.*
*.key
*.pem
*.p12
*.pfx
secrets/
*.pcap
*.pcapng
*.har
*.zip
*.7z
*.tar
*.gz
__pycache__/
*.py[cod]
.pytest_cache/
.venv/
venv/
.DS_Store
EOF_PROJECT_GITIGNORE

(
  cd "$project_dir"
  git init
  git branch -M main
  git add .
  git commit -m "Initial $project_name project"
  if [[ -n "$remote_url" ]]; then
    git remote add origin "$remote_url"
    git push -u origin main
  fi
)

printf 'Created standalone red-team project repo: %s\n' "$project_dir"
if [[ -z "$remote_url" ]]; then
  printf 'Create a GitHub repo for this project, then run:\n'
  printf '  cd %q && git remote add origin <repo-url> && git push -u origin main\n' "$project_dir"
fi