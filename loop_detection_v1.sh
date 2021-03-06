#!/bin/bash
#Detect loops in the istats hadoop post

FILE="/tmp/current_iplayer_file"

if [ -f "$FILE" ]
then
        job_type=`hadoop dfs -ls  hdfs://hadoopn.rep-back.lh.omg.bbc.co.uk/user/lisuser/iplayer_livestats/ | tail -n 1 |awk {'print $8'} | cut -d "/" -f 4`
        Old_File=$(cat /tmp/current_iplayer_file)
        Current_File=`egrep '\-put /var/istats/lisuser/var/poller/iplayer_livestats' /var/log/istats/lisuser/lisv2-app.log  | awk {'print $10'}| tail -n 1`
        #DFS_FILE=`hadoop dfs -ls  hdfs://hadoopn.rep-back.lh.omg.bbc.co.uk/user/lisuser/iplayer_livestats/ | tail -n 1 |awk {'print $8'}`
        #if [ "$Current_File" == "$Old_File" && -z "$DFS_FILE" ]
         if [ "$Current_File" == "$Old_File" ]

                then
                         mail -s "LIVE - DO NOT IGNORE - Looping Iplayer Istats - https://confluence.dev.bbc.co.uk/display/iStatsAV/iStats+AV+run+book " < /tmp/current_iplayer_file osman.marks.ext@bbc.co.uk tom.collins@bbc.co.uk craig.phillips@bbc.co.uk david.hodgkinson.ext@bbc.co.uk FMAnalyticsSupportTeam@bbc.co.uk
                else
                echo "All Looks Good"
                echo "$Current_File" > /tmp/current_iplayer_file
                exit 0
                fi

else
        echo " No Record of previous run"
        egrep '\-put|Executing /usr/lib/hadoop/bin/hadoop fs -put /var/istats/lisuser/var/poller/iplayer_livestats' /var/log/istats/lisuser/lisv2-app.log  | awk {'print $10'} | tail -n 1 > /tmp/current_iplayer_file
        exit
fi
