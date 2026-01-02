#!/usr/bin/env bash
# ==============================
# Linux Log Analyzer
# ==============================

# Detect auth log based on distro
if [[ -f /var/log/auth.log ]]; then
    LOG_FILE="/var/log/auth.log"
elif [[ -f /var/log/secure ]]; then
    LOG_FILE="/var/log/secure"
else
    echo "Error: No supported authentication log found."
    exit 1
fi

# Usage/help function
usage() {
    echo "Usage: $0 [--count | --ips | --all]"
    echo
    echo "Options:"
    echo "  --count   Show number of failed SSH login attempts"
    echo "  --ips     Show top attacking IP addresses"
    echo "  --all     Show full report (default)"
    exit 1
}

# Parse arguments
MODE="all"

case "$1" in
    --count) MODE="count" ;;
    --ips)   MODE="ips" ;;
    --all|"") MODE="all" ;;
    *) usage ;;
esac

# ==============================
# Functions
# ==============================

failed_count() {
    grep -c "Failed password" "$LOG_FILE"
}

top_ips() {
    grep "Failed password" "$LOG_FILE" \
    | awk '{print $(NF-3)}' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head
}

# ==============================
# Output
# ==============================

case "$MODE" in
    count)
        echo "Failed SSH login attempts:"
        failed_count
        ;;
    ips)
        echo "Top attacking IP addresses:"
        COUNT=$(failed_count)
        if [[ "$COUNT" -eq 0 ]]; then
            echo "No attacker IPs found."
        else
            top_ips
        fi
        ;;
    all)
        echo "===== FAILED SSH LOGIN ATTEMPTS ====="
        COUNT=$(failed_count)
        if [[ "$COUNT" -eq 0 ]]; then
            echo "No failed SSH login attempts found."
        else
            echo "$COUNT"
        fi

        echo
        echo "===== TOP ATTACKING IP ADDRESSES ====="
        if [[ "$COUNT" -eq 0 ]]; then
            echo "No attacker IPs found."
        else
            top_ips
        fi
        ;;
esac


