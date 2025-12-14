#!/bin/bash

echo "================ Server Performance Stats ================"
echo "Hostname       : $(hostname)"
echo "Uptime         : $(uptime -p)"
echo "Date & Time    : $(date)"
echo "=========================================================="
echo

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "Total CPU Usage: ${CPU_USAGE}%"
echo

# Memory Usage
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")

echo "Memory Usage:"
echo "Total: ${MEM_TOTAL} MB"
echo "Used : ${MEM_USED} MB"
echo "Free : ${MEM_FREE} MB"
echo "Usage: ${MEM_PERCENT}%"
echo

# Disk Usage
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

echo "Disk Usage (/):"
echo "Total: ${DISK_TOTAL}"
echo "Used : ${DISK_USED}"
echo "Free : ${DISK_FREE}"
echo "Usage: ${DISK_PERCENT}"
echo

# Top 5 Processes by CPU
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 Processes by Memory
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

echo "======================== End =============================="

