#!/bin/bash

function prepareResultsEmail() {
	EMAIL_LOG_LINE_LIMIT_OFFSET=$(("$EMAIL_LOG_LINE_LIMIT"-1))
	BODY_BUILD=$(sed -n 1,"$EMAIL_LOG_LINE_LIMIT_OFFSET"p $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.log)
	fileCount=$(wc -l "$LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.log" | awk '{print $1}')
	echo "Backup Job for [$r] $jobStatus"
	echo "================================================================="
	echo ""
	echo "The following errors occured (if any)"
	echo "================================================================="
	declare -a jobErrorsArary
	readarray jobErrorsArary < $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.error.log
	let x=0
		while (( ${#jobErrorsArary[@]} > x )); do
			printf "${jobErrorsArary[x++]}"
		done
	echo "================================================================="
	echo ""
	echo ""
	echo "The following files were included in this backup job:"
	echo "Number of files that were included in this backup: [$fileCount]"
	echo "See $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.log for more details."
	echo "(Displayed results limited to $EMAIL_LOG_LINE_LIMIT lines per your configuration.)"
	echo "================================================================="
	echo $BODY_BUILD | tr " " "\n"
	echo "================================================================="
}

function sendResultsEmail() {
	prepareResultsEmail | mail -r $EMAIL_FROM -s "Backup Job [$r] $jobStatus" $EMAIL_TO
}