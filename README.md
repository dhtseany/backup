# backup
A simple tar based incremental daily backup script (systemd based) that utilizes pigz for multithreaded compression. It generates log files that can be referenced for checks performed by modern RMM solutions as well as emailed using the optional SMTP functionality. 

This package has the following dependencies:
- tar
- pigz
- bash 4.0 or newer

To install:
1. Copy ./backup.conf to /etc/backup.conf then edit the fields provided. 
2. Copy ./backup to /usr/bin/backup/backup.
3. Copy ./email.sh to /usr/bin/backup/email.sh
4. Copy ./backup.service to /etc/systemd/system/backup.service. 
5. Copy ./backup.timer to /etc/systemd/system/backup.timer. Edit the file's options, most notably when the backup scripts will run.
6. Create the /var/log/backup directory
7. Once settings are all in place as expected, enable and start associated systemd service:
$ sudo systemctl enable backup.timer

To configure email support:
1. Install and configure postfix per your distro's Wiki, support, or man pages.
2. Edit /etc/backup.conf and set EMAIL_SUPPORT to yes, then configure your desired email addresses accordingly.

Email support is still in it's infant stages, and will become more robust in future versions as need dictates.

To Do:
============
1. Improve email support
2. Create graphical menus for product configuration
3. Create backup set rotation capabilities.
4. Add the ability for user to choose rsync instead of tar.

Change Log:
v1.2.1
    - Started keeping a change log
    - Improved email report to limit oversized emails and inherint rejection from external mail servers
v1.2.2
    - Improved initial checks for existence of LOG_DIR to prevent initial failures during first run
    - Adjusted how 

v1.2.3
    - Limited results for error log since fix applied in 1.2.1 didn't cover error log