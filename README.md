# Cybersecurity Project Workspace

Organize authorized cybersecurity projects across red-team testing, blue-team detection, lab builds, and reporting — in one structured workspace.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=bash)](https://www.gnu.org/software/bash/)

## What It Is

A workspace template for running legal, permission-based cybersecurity engagements. Each project gets its own folder, scripts, and structure — red team, blue team, or lab — so nothing gets lost between engagements.

**This workspace is for authorized work only.** Keep every engagement tied to written authorization.

## Quickstart

```bash
git clone https://github.com/aimansam/cyber-project-workspace.git
cd cyber-project-workspace

# Create a new red-team project
./scripts/create-red-team-project.sh "Project Name" https://github.com/USER/PROJECT.git

# Create a new blue-team project
./scripts/create-blue-team-project.sh "Project Name" https://github.com/USER/PROJECT.git
```

## Project Types

| Type | Purpose | Script |
|------|---------|--------|
| Red team | Offensive testing, authorized | `create-red-team-project.sh` |
| Blue team | Detection, response, logging | `create-blue-team-project.sh` |
| Lab | Isolated testing environment | `create-lab-project.sh` |

## Structure

Each project gets:

```
project-name/
├── README.md          # Project charter, scope, authorization ref
├── scope.md           # In-scope / out-of-scope
├── findings/          # Reports, notes, evidence
├── scripts/           # Engagement-specific tooling
└── logs/              # Session logs, timestamps
```

## Authorization

Before starting any project:

1. Get written authorization for the target.
2. Record the authorization reference in `scope.md`.
3. Keep findings tied to the engagement folder.

## License

MIT — see [LICENSE](LICENSE).

*For authorized cybersecurity work only.*
