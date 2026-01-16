#!/bin/bash

set -e     #exit if error encounter

# #Store data in a file
touch record.txt

#Helper function for clean up
cleanup()
{
    rm record.txt
}

#Trap any error
trap cleanup ERR

{
    echo ""
    echo "+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-"
    echo ""

    echo "System Snapshot"
    echo "Date: $(date)"
    echo "Time: $(date "+%T")"

    echo ""
    echo "+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-"
    echo ""

    awk -F= '/PRETTY_NAME/ {printf("PRETTY_NAME: %s\n",$2)}' /etc/os-release
    echo "Kernal: $(uname -r)"
    echo "Uptime: $(uptime -p | awk '{print($2$4)}')"
    echo "Memory Size: $(free -h | awk '/^Mem/ {printf($2)}')"
    echo "CPU info:"
    lscpu | awk -F: '/Architecture/ {print($1$2)}'
    lscpu | awk -F: '/CPU op-mode\(s\)/ {print $1$2}'
    lscpu | awk -F: '/CPUS\(s\)/ {print $1$2}'
    lscpu | awk -F: '/Socket\(s\)/ {print}'
} >> record.txt

{
    echo ""
    echo "+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-"
    echo ""
    echo "CPU Configuration:-"                        
    mpstat | awk '/all/ {printf("CPU usages: %.2f%\n", 100 - $12)}'    #show CPU usages in percetages

    echo ""
    echo "+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-"
    echo ""

    echo "Memory Configuration:-"
    free -h   #Total memory used
    echo ""

    echo "Precentage:- "
    free | awk '/^Mem/ {printf("Used: %.2f%\n" , $3/$2 * 100)}' # Used memory 
    free | awk '/Mem/ {printf("Free: %.2f%\n" , $4/$2 * 100 )}'  # Free memory

    echo ""
    echo "+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-"
    echo ""

    echo "Disk Configuration:- "
    df / | awk 'NR==2 {printf("Disk in use: %.2f%%\n", $3/$2*100)}'   # percentange of memory is in use
    df / | awk 'NR==2 {printf("Disk free: %.2f%%\n", 100-($3/$2*100))}'  # percentage of free memory
} >> record.txt

{
    echo ""
    echo "+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-++-+-"
    echo ""

    echo "Processes:"
    echo ""
    echo "CPU Consumer:-"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6  # 5 processes consume most CPU
    echo""
    echo "Memory Consumer:-"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6  # 5 processes consume most RAM
    echo ""
} >> record.txt

echo "Successfully excecuted."


