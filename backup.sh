#!/bin/bash

DATE=$(date)
DOW=$(date +%u)
WEEK=$(date +%V)
MONTH=$(date +"%m")
YEAR=$(date +"%y")

echo "Backup Set Run on $DATE" >> /var/log/backup.log

function PublicBackup() {
        EXECUTE=$(tar --listed-incremental=/storage/Backups/Public-$WEEK.snap -I pigz -cf /storage/Backups/Public-$YEAR-$MONTH-$DOW.tar.gz /storage/mounts/Public 3>&1 1>&2 2>&3)
                if [ $? = 0 ]
                        then
                                echo "STATUS=0" >> /var/log/backup.log
                        else
                                echo "STATUS=1" >> /var/log/backup.log
                fi
}
PublicBackup