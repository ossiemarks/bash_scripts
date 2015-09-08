#!/bin/bash
# Check if pipeline is disabled

ON=`cat /etc/sysconfig/bbc-istats-controller | head -n9 | tail -n 1 | cut -f 2 -d '"' `

if [ $ON -gt 0 ]
then
echo "PIPELINE IS ON"
else
mail -s "PIPELINE IS TURNED OFF" osman.marks.ext@bbc.co.uk < `date`
fi
