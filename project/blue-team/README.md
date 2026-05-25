# Blue-Team Projects

Use this area for monitoring, detection engineering, incident response, and hardening work.

## Project Folder Pattern

```text
project/blue-team/
  project-name/
    objective.md
    data-sources.md
    detections.md
    validation.md
    response-playbook.md
```

## Workflow

1. Define the threat or behavior to detect.
2. Identify required logs and telemetry.
3. Write a detection rule, query, or analytic.
4. Validate in the lab or with approved production telemetry.
5. Record false positives and tuning decisions.
6. Create response steps and escalation guidance.
7. Link detections to red-team or lab evidence.

## Starter Project Ideas

- Wazuh or Elastic lab ingestion pipeline.
- Sigma rule library for common web and endpoint events.
- Suricata/Zeek network detection experiments.
- Incident response playbooks for account compromise, web shell activity, and malware alerts.
- Vulnerability management dashboard and remediation tracker.

## Detection Metadata

Track these fields for each detection:

- Name
- Objective
- Data source
- Query/rule path
- Severity
- MITRE ATT&CK mapping
- Validation evidence
- Known false positives
- Owner
- Review date
