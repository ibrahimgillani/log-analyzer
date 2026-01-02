# Linux Log Analyzer

A lightweight Bash-based log analyzer for Linux systems that inspects authentication logs to detect failed SSH login attempts and identify potential attacking IP addresses.

This tool is designed for learning Linux internals, system administration, and DevOps/SOC fundamentals.

---

## Features

- Detects failed SSH login attempts
- Identifies top attacking IP addresses
- Supports Ubuntu/Debian (`/var/log/auth.log`)
- Supports RHEL/CentOS/Fedora (`/var/log/secure`)
- Clean CLI interface with flags
- Safe, read-only log analysis

---

## Requirements

- Linux system
- Bash
- Root privileges (required to read auth logs)

---

## Installation

Clone the repository:

```bash
git clone https://github.com/your-username/log-analyzer.git
cd log-analyzer
