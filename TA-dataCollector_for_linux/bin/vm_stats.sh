#!/bin/bash

VM_NAME=$(hostname)
DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
OS_VERSION=$(awk -F= '/^PRETTY_NAME/{print $2}' /etc/os-release | tr -d '"')
IP_ADDRESS=$(hostname -I | awk '{print $1}')
CPU_CORES=$(nproc)
CPU_LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1 | xargs)
MEM_TOTAL=$(free -m | awk '/Mem:/ { print $2 }')
MEM_USED=$(free -m | awk '/Mem:/ { print $3 }')
DISK_TOTAL=$(df -h / | awk 'NR==2 { print $2 }')
DISK_USED=$(df -h / | awk 'NR==2 { print $3 }')
UPTIME=$(awk '{print int($1)}' /proc/uptime)

echo "{
  \"vm_name\": \"$VM_NAME\",
  \"datetime\": \"$DATE_TIME\",
  \"os_version\": \"$OS_VERSION\",
  \"ip_address\": \"$IP_ADDRESS\",
  \"cpu_cores\": \"$CPU_CORES\",
  \"cpu_load_1min\": \"$CPU_LOAD\",
  \"memory_total_mb\": \"$MEM_TOTAL\",
  \"memory_used_mb\": \"$MEM_USED\",
  \"disk_total\": \"$DISK_TOTAL\",
  \"disk_used\": \"$DISK_USED\",
  \"uptime_seconds\": \"$UPTIME\"
}"
