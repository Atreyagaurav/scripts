#!/usr/bin/env bash
logfile="work.log"
echo "$(date) - START $@">> $logfile
echo "Job Started: $@"
echo "Press any key when you're done."
SECONDS=0
while [ true ] ; do
    read -t 3 -n 1
    if [ $? = 0 ] ; then
	echo "$(date) - END $@">> $logfile
	echo "Job Ended: $@"
	exit ;
    else
	printf "\r%2dh %2dm %2ds elapsed." $(($SECONDS / 3600)) $((($SECONDS / 60) % 60)) $(($SECONDS % 60))
    fi
done
