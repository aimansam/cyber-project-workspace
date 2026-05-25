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

project_dir="$workspace_root/project/blue-team/$slug"

if [[ -e "$project_dir" ]]; then
  printf 'Project already exists: %s\n' "$project_dir" >&2
  exit 1
fi

mkdir -p "$project_dir/detections" "$project_dir/evidence" "$project_dir/reports" "$project_dir/playbooks"

cat > "$project_dir/README.md" <<EOF_PROJECT_README
# $project_name Blue-Team Project

Purpose: document defensive monitoring, detection engineering, incident response, or hardening work for this project.

This project is an independent Git repository inside the larger cybersecurity workspace. Keep data sources, detections, validation evidence, and reports inside this project folder so it can be pushed to its own GitHub repository.

## Folder Map

\`\`\`text
$slug/
  README.md
  objective.md
  data-sources.md
  detections.md
  validation.md
  response-playbook.md
  detections/
  evidence/
  reports/
  playbooks/
\`\`\`

## Milestones

1. Complete \`objective.md\` before writing detections.
2. Confirm approved data sources.
3. Draft and review detection logic.
4. Validate with lab or approved telemetry.
5. Store validation evidence under \`evidence/\`.
6. Write response and tuning notes.

## Safety Baseline

- Use approved telemetry only.
- Do not commit secrets, raw personal data, or unapproved customer data.
- Redact sensitive values before publishing reports or blog material.
EOF_PROJECT_README

cat > "$project_dir/objective.md" <<EOF_OBJECTIVE
# Objective

## Project

- Name: $project_name
- Owner:
- Start date:
- Review date:

## Detection or Defense Goal

- Threat behavior:
- Environment:
- Expected signal:
- Response goal:

## Success Criteria

- Detection coverage:
- False-positive tolerance:
- Validation method:
EOF_OBJECTIVE

cat > "$project_dir/data-sources.md" <<'EOF_DATA_SOURCES'
# Data Sources

| Source | Location | Owner | Retention | Notes |
| --- | --- | --- | --- | --- |

## Handling Rules

- Use only approved logs and telemetry.
- Redact sensitive identifiers before sharing.
- Track query/export timestamps.
EOF_DATA_SOURCES

cat > "$project_dir/detections.md" <<'EOF_DETECTIONS'
# Detections

## Detection Template

### Name

### Objective

### Data Source

### Logic

### Severity

### MITRE ATT&CK Mapping

### Known False Positives

### Tuning Notes
EOF_DETECTIONS

cat > "$project_dir/validation.md" <<'EOF_VALIDATION'
# Validation

| Date/Time | Detection | Data Source | Test Method | Result | Evidence |
| --- | --- | --- | --- | --- | --- |
EOF_VALIDATION

cat > "$project_dir/response-playbook.md" <<'EOF_PLAYBOOK'
# Response Playbook

## Trigger

## Triage Steps

## Containment

## Eradication

## Recovery

## Escalation

## Communication Notes
EOF_PLAYBOOK

cat > "$project_dir/evidence/README.md" <<'EOF_EVIDENCE'
# Evidence

Store validation evidence for this project here.

Do not commit secrets, tokens, cookies, API keys, private personal data, or unapproved customer information.
EOF_EVIDENCE

cat > "$project_dir/reports/report.md" <<EOF_REPORT
# $project_name Defensive Report

Status: Draft

## Executive Summary

## Objective

## Data Sources

## Detection Summary

## Validation Results

## Recommendations

## Follow-Up Work
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

printf 'Created standalone blue-team project repo: %s\n' "$project_dir"
if [[ -z "$remote_url" ]]; then
  printf 'Create a GitHub repo for this project, then run:\n'
  printf '  cd %q && git remote add origin <repo-url> && git push -u origin main\n' "$project_dir"
fi