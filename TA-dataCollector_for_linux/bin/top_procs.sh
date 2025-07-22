#!/bin/bash

VM_NAME=$(hostname)
DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Get top 5 processes by CPU and memory
ps -eo pid,comm,%cpu,%mem,rss,user --sort=-%cpu | head -n 6 | tail -n 5 | while read pid proc cpu mem rss user
do
  echo "{
    \"vm_name\": \"$VM_NAME\",
    \"datetime\": \"$DATE_TIME\",
    \"pid\": \"$pid\",
    \"proc_name\": \"$proc\",
    \"cpu_percent\": \"$cpu\",
    \"memory_percent\": \"$mem\",
    \"memory_rss_mb\": \"$(echo "scale=2; $rss/1024" | bc)\",
    \"user\": \"$user\"
  }"
done
