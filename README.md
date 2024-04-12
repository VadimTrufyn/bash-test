# Backup Script

This script creates backup archives for specified directories and rotates old backup archives based on a specified period.

## Usage

To use this script, follow the instructions below:

1. Clone the repository:

   ```bash
   git clone https://github.com/VadimTrufyn/bash-test.git
   ```
2. Navigate to the script directory:
   ```bash
   cd bash-test
   ```
3. Run the script with the following options:

-s or --source : Specify the source directory for backup. Default is /var/log/.
-d or --destination : Specify the destination directory for backup archives. Default is /var/backup_log.
-p or --period : Specify how often to rotate backup archives in days. Default is 7 days.
Example:
```bash
./backup_script.sh -s /path/to/source -d /path/to/destination -p 7
```
4. The script will create backup archives for all files in the source directory and rotate old backup archives in the destination directory based on the specified period.

   
   
