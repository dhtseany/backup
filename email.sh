#!/bin/bash

function prepareResultsEmail() {
	EMAIL_LOG_LINE_LIMIT_OFFSET=$(("$EMAIL_LOG_LINE_LIMIT"-1))
	includedFilesLimited=$(sed -n 1,"$EMAIL_LOG_LINE_LIMIT_OFFSET"p $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.log)
	involvedErrorsLimited=$(sed -n 1,"$EMAIL_LOG_LINE_LIMIT_OFFSET"p $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.error.log)
	fileCount=$(wc -l "$LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.log" | awk '{print $1}')
	errorCount=$(wc -l "$LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.error.log" | awk '{print $1}')
	echo "Backup Job for [$r] $jobStatus"
	echo "================================================================="
	echo ""
	echo "A total of [$errorCount] errors occured."
	echo "See $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.error.log for more details."
	echo "(Displayed results limited to $EMAIL_LOG_LINE_LIMIT lines per your configuration.)"
	echo "================================================================="
	echo $involvedErrorsLimited | tr " " "\n"
	echo "================================================================="
	echo ""
	echo ""
	echo "The following files were included in this backup job:"
	echo "Number of files that were included in this backup: [$fileCount]"
	echo "See $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.log for more details."
	echo "(Displayed results limited to $EMAIL_LOG_LINE_LIMIT lines per your configuration.)"
	echo "================================================================="
	echo $includedFilesLimited | tr " " "\n"
	echo "================================================================="
}

function sendResultsEmail() {
	prepareResultsEmail | mail -r $EMAIL_FROM -s "Backup Job [$r] $jobStatus" $EMAIL_TO
}