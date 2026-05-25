# Scripts

Use this area for helper scripts that support authorized testing, evidence processing, reporting, and lab maintenance.

## Guardrails

- Keep scripts scoped to approved assets or local lab systems.
- Add dry-run modes for anything that changes state.
- Avoid storing secrets in source files.
- Log actions clearly when scripts touch targets or evidence.

## Starter Script Ideas

- Scope-aware URL inventory parser.
- Evidence filename normalizer.
- Report finding formatter.
- Lab snapshot checklist generator.
- Detection validation runner for local sample logs.

## Current Scripts

### `cyber-menu.sh`

Interactive all-in-one menu for common workspace actions.

```bash
./menu.sh
```

Menu options include creating red-team or blue-team project repos, listing project repos, checking status, setting project GitHub remotes, and committing/pushing workspace or project repos.

### `create-red-team-project.sh`

Creates a new red-team project as an independent Git repository under `project/red-team/`.

```bash
./scripts/create-red-team-project.sh "Project Name"
./scripts/create-red-team-project.sh "Project Name" https://github.com/USER/PROJECT.git
```

### `create-blue-team-project.sh`

Creates a new blue-team project as an independent Git repository under `project/blue-team/`.

```bash
./scripts/create-blue-team-project.sh "Project Name"
./scripts/create-blue-team-project.sh "Project Name" https://github.com/USER/PROJECT.git
```

The parent workspace `.gitignore` excludes project folders, so each project can be pushed to its own GitHub repository.
