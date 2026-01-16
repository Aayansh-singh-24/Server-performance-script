# Server Performance Monitoring Script

This repository contains a simple Bash script that collects basic system performance and health information on a Linux system.  
The script is useful for learning Linux monitoring, shell scripting, and system administration fundamentals.

---

## What This Repository Contains

The script collects and logs the following information:

- Operating System version
- System uptime
- Load average (1, 5, and 15 minutes)
- Total RAM size
- Disk size of the root filesystem
- Top CPU-consuming processes
- Top memory-consuming processes
- Logged-in users

All data is stored in a log file for future reference.

---

## Technologies Used

- Bash / Shell scripting
- Linux system utilities:
  - `uptime`
  - `free`
  - `df`
  - `ps`
  - `awk`
  - `who`
  - `/proc` filesystem

---

## How to Execute the Script

```text
# Clone the repository
git clone https://github.com/Aayansh-singh-24/Server-bash-script.git
cd Server-Performance

# Give execute permission
chmod +x server_performance.sh

# Run the script
./server_performance.sh

# View the output
cat record.txt
