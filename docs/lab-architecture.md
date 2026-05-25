# Lab Architecture Plan

Build a local lab for repeatable red-team and blue-team practice without touching unauthorized systems.

## Recommended Zones

- `attacker`: Kali or security workstation.
- `targets`: intentionally vulnerable hosts, web apps, Windows/AD lab machines, and Linux services.
- `monitoring`: SIEM, log collector, packet capture, and endpoint telemetry.
- `management`: documentation, backups, and version-controlled configs.

## Starter Services

| Role | Example Options | Notes |
| --- | --- | --- |
| SIEM | Wazuh, Elastic, Security Onion, Splunk Free | Pick one first to keep the lab manageable. |
| Packet capture | Zeek, Suricata, tcpdump | Mirror traffic where possible. |
| Endpoint telemetry | Sysmon, osquery, Wazuh agent | Keep event configuration versioned. |
| Vulnerable targets | Juice Shop, DVWA, Metasploitable, VulnHub boxes | Use isolated networks. |
| Directory lab | Windows Server + Windows clients | Snapshot before tests. |

## Network Notes

- Keep lab networks isolated from home, work, and production networks.
- Snapshot virtual machines before risky testing.
- Store tool output under `evidence/lab/`.
- Mirror notable attack steps into blue-team detections.

## Build Phases

1. Create isolated network and base VMs.
2. Add one vulnerable web application and one Linux target.
3. Add SIEM/log collector and validate ingestion.
4. Add Windows endpoint telemetry.
5. Add AD lab only after logging and snapshots are reliable.
