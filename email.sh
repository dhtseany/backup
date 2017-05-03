#!/bin/bash

function prepareResultsEmail() {
	echo "Backup Job for [$r] $jobStatus"
	echo ""
	echo "The following errors occured (if any)"
	echo "====================================="
	declare -a jobErrorsArary
	readarray jobErrorsArary < $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.error.log
	let x=0
		while (( ${#jobErrorsArary[@]} > x )); do
			printf "${jobErrorsArary[x++]}"
		done
	echo ""
	echo "Files that were included in this backup:"
	echo "====================================="
	declare -a jobResults
	readarray jobResults < $LOG_DIR/$JOB_NAME-$YEAR-$MONTH-$DOW.log
	let y=0
		while (( ${#jobResults[@]} > y )); do
			printf "${jobResults[y++]}"
		done
}

function sendResultsEmail() {
prepareResultsEmail | mail -r $EMAIL_FROM -s "Backup Job [$r] $jobStatus" $EMAIL_TO
}