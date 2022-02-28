#!/usr/bin/env bash
echo "$(date) - START $@">> work.log
echo "Job Started: $@"
echo "Press any key when you're done."
while [ true ] ; do
    read -t 3 -n 1
    if [ $? = 0 ] ; then
	echo "$(date) - END $@">> work.log
	echo "Job Ended: $@"
	exit ;
    fi
done
