#!/bin/bash
# Check if pipeline is disabled
ON=`cat /etc/sysconfig/bbc-istats-controller | head -n9 | tail -n 1 | cut -f 2 -d '"' `
host=`hostname -f`
if [ $ON -gt 0 ]
then
echo "PIPELINE IS ON"
else
mail -s "PIPELINE IS TURNED OFF ${host} " osman.marks.ext@bbc.co.uk tom.collins@bbc.co.uk craig.phillips@bbc.co.uk david.hodgkinson.ext@bbc.co.uk iStatsAVSupport@bbc.co.uk < /tmp/problems
fi
