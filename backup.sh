#!/bin/bash

source /etc/backup.conf
DATE=$(date)
DOW=$(date +%u)
WEEK=$(date +%V)
MONTH=$(date +"%m")
YEAR=$(date +"%y")
echo "Backup Set Run on $DATE" >> /var/log/backup.log

for i in ${BACKUP_DIR[@]}
        do
                JOB_NAME=${i##*/}
                EXECUTE=$(tar --listed-incremental=$OUTPUT_DIR/$JOB_NAME-$WEEK.snap -I pigz -cf $OUTPUT_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.tar.gz $i 3>&1 1>&2 2>&3)
                        if [ $? = 0 ]
                                then
                                        echo "Job name $JOB_NAME processed successfully." >> /var/log/backup.log
                                        echo "STATUS=0" >> /var/log/backup.log
                                else
                                        echo "Job name $JOB_NAME failed." >> /var/log/backup.log
                                        echo "STATUS=1" >> /var/log/backup.log
                        fi
done