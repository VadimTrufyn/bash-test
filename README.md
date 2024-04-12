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
3. Change permision for executions
   ```bash
   sudo chmod +x backup.sh 
3. Run the script with the following options:

   + -s  Specify the source directory for backup. Default is /var/log/.
   + -d  Specify the destination directory for backup archives. Default is /var/backup_log.
   + -p  Specify how often to rotate backup archives in days. Default is 7 days.
Example:
```bash
./backup.sh -s /path/to/source -d /path/to/destination -p 7
```
4. The script will create backup archives for all files in the source directory and rotate old backup archives in the destination directory based on the specified period.

##Automation
To automate the script and make it available from any directory, you can add the script to your PATH or move it to a directory already in your PATH.


I choose to move the script to the directory */usr/local/bin*. Now our script will be executable from anywhere.

To move the script to */usr/local/bin*, use the following command:

```bash
sudo mv backup.sh /usr/local/bin
```
##Running Automatically with Cron
You can also schedule the script to run automatically using cron. To do this, follow these steps:


1. Open the crontab for editing:

```bash
crontab -e
```
Add a line to the crontab to run the script with the desired schedule. For example, to run the script every day at 3:00 AM:

```bash
0 3 * * * /usr/local/bin/backup_script.sh -s /var/log/ -d /var/backup_log -p 7
```
Where:

* 0 3 * * * is the schedule (every day at 3:00 AM),
* /usr/local/bin/backup_script.sh is the path to your script,
* -s /var/log/ -d /var/backup_log -p 7 are the parameters for your script.
2. Save the changes and close the crontab editor.


This line will run your script every day at 3:00 AM and automatically create and rotate backup archives according to the specified parameters. You can change the schedule and other cron settings as needed.
