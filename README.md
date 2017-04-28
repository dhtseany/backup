# backup
A simple tar based incremental daily backup script (systemd based) that utilizes pigz for mulithreaded compression. It generates log files that can be referenced for checks performed by modern RMM solutions as well as emailed using the optional SMTP functionality. 

This package has the following dependancies:
- tar
- pigz
- bash 4.0 or newer

To install:
1. Copy ./backup.conf to /etc/backup.conf then edit the fields provided. 
2. Copy ./backup to /usr/bin/backup/backup.
3. Copy ./backup.service to /etc/systemd/system/backup.service. 
4. Copy ./backup.timer to /etc/systemd/system/backup.timer. Edit the file's options, most notably when the file will run.
5. Once settings are all in place as expected, enable and start associated systemd service:
$ sudo systemctl enable backup.timer -now