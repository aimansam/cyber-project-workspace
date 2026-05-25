# Tools

Use this area for tool configuration notes, wrappers, and repeatable command references.

## Suggested Layout

```text
tools/
  burp/
  nmap/
  nuclei/
  wazuh/
  zeek/
  suricata/
```

## Notes

- Keep tool configs tied to authorized scope.
- Store large outputs under `evidence/`, not here.
- Redact sensitive values before committing or sharing configs.
