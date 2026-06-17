#!/bin/bash

# ==========================================
# Variabel Warna & Format (ANSI Codes)
# ==========================================
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Memulai Loop Tanpa Henti
while true; do

    # Membersihkan layar setiap kali refresh
    clear

    echo -e "${CYAN}${BOLD}"
    echo "  ███████╗████████╗ █████╗ ████████╗███████╗"
    echo "  ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██╔════╝"
    echo "  ███████╗   ██║   ███████║   ██║   ███████╗"
    echo "  ╚════██║   ██║   ██╔══██║   ██║   ╚════██║"
    echo "  ███████║   ██║   ██║  ██║   ██║   ███████║"
    echo "  ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚══════╝"
    echo -e "${NC}"
    echo -e "${MAGENTA}${BOLD}     [ SYSTEM PERFORMANCE DASHBOARD (LIVE) ]${NC}\n"

    # ---------------------------------------------
    # 1. System Information
    # ---------------------------------------------
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BOLD} 🖥️  SYSTEM INFORMATION ${NC}"
    echo -e "${BLUE}===============================================${NC}"
    echo -e " ${BOLD}OS Version:${NC}     $(grep PRETTY_NAME /etc/os-release | cut -d '=' -f 2 | tr -d '"')"
    echo -e " ${BOLD}Uptime:${NC}         ${GREEN}$(uptime -p)${NC}"
    echo -e " ${BOLD}Load Average:${NC}   ${YELLOW}$(cat /proc/loadavg | awk '{print $1, $2, $3}')${NC}"
    echo -e " ${BOLD}Logged In:${NC}      $(who | wc -l) User(s)\n"

    # ---------------------------------------------
    # 2. Total CPU Usage
    # ---------------------------------------------
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BOLD} ⚙️  CPU USAGE ${NC}"
    echo -e "${BLUE}===============================================${NC}"

    read -r cpu user nice system idle iowait irq softirq steal guest < /proc/stat
    cpu_idle=$idle
    cpu_total=$((user + nice + system + idle + iowait + irq + softirq + steal))

    # Waktu tunggu untuk kalkulasi CPU (Ini sekaligus menjadi jeda refresh Dashboard)
    sleep 1

    read -r cpu user nice system idle iowait irq softirq steal guest < /proc/stat
    cpu_idle_diff=$((idle - cpu_idle))
    cpu_total_diff=$((user + nice + system + idle + iowait + irq + softirq + steal - cpu_total))

    cpu_usage=$((100 * (cpu_total_diff - cpu_idle_diff) / cpu_total_diff))

    if [ "$cpu_usage" -ge 80 ]; then
        CPU_COLOR=$RED
    elif [ "$cpu_usage" -ge 50 ]; then
        CPU_COLOR=$YELLOW
    else
        CPU_COLOR=$GREEN
    fi

    echo -e " ${BOLD}Total CPU Usage:${NC} ${CPU_COLOR}${cpu_usage}%${NC}\n"

    # ---------------------------------------------
    # 3. Total Memory Usage
    # ---------------------------------------------
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BOLD} 🧠 MEMORY USAGE ${NC}"
    echo -e "${BLUE}===============================================${NC}"
    free -m | awk 'NR==2{printf " %-10s: %s MB\n %-10s: %s MB\n %-10s: %s MB\n %-10s: %.2f%%\n", "Total", $2, "Used", $3, "Free", $4, "Usage", $3*100/$2 }'
    echo ""

    # ---------------------------------------------
    # 4. Total Disk Usage
    # ---------------------------------------------
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BOLD} 💾 DISK USAGE ${NC}"
    echo -e "${BLUE}===============================================${NC}"
    df -h --total | awk 'END{printf " %-10s: %s\n %-10s: %s\n %-10s: %s\n %-10s: %s\n", "Total", $2, "Used", $3, "Free", $4, "Usage", $5}'
    echo ""

    # ---------------------------------------------
    # 5. Top 5 Processes by CPU
    # ---------------------------------------------
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BOLD} 🔥 TOP 5 PROCESSES BY CPU ${NC}"
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${CYAN} PID    USER       COMMAND         %CPU  %MEM${NC}"
    ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf " %-6s %-10s %-15s %-5s %-5s\n", $1, $2, $3, $4, $5}'
    echo ""

    # ---------------------------------------------
    # 6. Top 5 Processes by Memory
    # ---------------------------------------------
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${BOLD} 📊 TOP 5 PROCESSES BY MEMORY ${NC}"
    echo -e "${BLUE}===============================================${NC}"
    echo -e "${CYAN} PID    USER       COMMAND         %MEM  %CPU${NC}"
    ps -eo pid,user,comm,%mem,%cpu --sort=-%mem | head -n 6 | tail -n 5 | awk '{printf " %-6s %-10s %-15s %-5s %-5s\n", $1, $2, $3, $4, $5}'
    echo ""

    echo -e "\n${CYAN}${BOLD}>> Tekan Ctrl+C untuk keluar <<${NC}\n"

    # Jeda 1 detik lagi agar loop tidak memberatkan CPU
    sleep 1

done
