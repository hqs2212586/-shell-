#!/bin/bash
#user=$USER
date=`date +%Y%m%d`
#deploy=/home/${user}/deploy/
deploy=~/deploy/
#deploy_backup=~/backup/${date}

LOG_HOME=~/logs/
read -p "please input the war name": war

case $war in
*)
esac

#kill tomcat
tmp=$(ps -ef | grep $war |grep tomcat )
APPID=$(echo $tmp | awk -F " " '{print $2}')
if [ -z $APPID ];
then
        echo -e "The app $war is not running!\n" 
else
        kill -9 ${APPID} &> /dev/null  && echo -e "The app $war has been killed!\n" ##|| echo -e "The app $war is not running!\n"
fi


#restart
count=1
#APPTOM=$(echo $tmp | sed  -r 's#.*-Dcatalina.base=(/.*) +-Dcatalina.home.*#\1#g')
APPTOM="/home/hbets/tomcats/$(ls /home/hbets/tomcats | grep  "$war"|grep -v bak)"
#${war}/bin/startup.sh && tail -f ${log_home}/${war}/app.log
#${war}/bin/startup.sh && tail -f ${war_home}/logs/catalina.out

while [ ${count} -le 3 ]
do
        read -p "Do you want to restart the app?(y/n)": signal
        case $signal in
                y|Y|yes|YES)
                ${APPTOM}/bin/startup.sh && tail -f ${APPTOM}/logs/catalina.out

                break
                ;;
                n|N|no|NO)
                break
                ;;
                *)
                let count+=1
                echo -e "$0: Invalid input, [ y|n|yes|no|Y|N|YES|NO ]\n\a"
                ;;
        esac
done
