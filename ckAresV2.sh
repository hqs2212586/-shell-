#!/bin/bash
#Check the parameter "monitor" in the file "ares-app-config.xml" and turn the value 'true' to 'false'

pdate=`date +%Y%m%d%H%M%S`
echo "date: ${pdate}" >> ares_info
areslist=`find ~/ -name "ares-app-config.xml" | grep -v "201" | grep -v "bak " | grep -v "/config"`
for ares in ${areslist}
do
        echo ${ares} >> ares_info
        grep monitor ${ares} >> ares_info
        echo >> ares_info

        tmp=`grep monitor ${ares} | grep "true"`
        if [ -n "${tmp}" ];
        then
                sed -i /\<monitor/s/true/false/ ${ares}
                ares_tmp="${ares_tmp}  `echo ${ares} | awk -F / '{print $5}'`"
        fi
done
echo ${ares_tmp} >> ares_info
echo -e "-----------------------------\n" >> ares_info
echo "You should restart [${ares_tmp}  ]!"
