#!/bin/bash
#user=$USER
date=`date +%Y%m%d`
#deploy=/home/${user}/deploy/
deploy=~/deploy/
deploy_backup=~/backup/${date}
war_home=~/share/fabu/${date}
LOG_HOME=~/logs/
read -p "please input the war name": war

mkdir -p $deploy_backup
case $war in 
hps-as|hps-admin|hps-webapp|hpsadmin|hpswebapp|base|baseadmin|chengdudao|dalidao|dalidao_hq|dalidaohq|dalidaotrade|fengshan|genshan|munandao|wulin|eq|eqadmin|fcadmin|fcgate|fcweb|broker)

	cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	ares=ares-app-config.xml
        jcc=jcc-config-new.xml
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	cp ${deploy_backup}/${war}/${conf}/${log}  ${deploy}/${war}/${conf}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	echo " ${war} 发布完成！"
	;;
chongqingdao)
        cd ${deploy}
        mv $war ${deploy_backup}
        class=WEB-INF/classes
        conf=WEB-INF/conf
        server=server.properties
        log=log4j.properties
        ares=ares-app-config.xml
        jcc=jcc-config-new.xml
        #cd ${fabu_home}/${date}_wars
        cd ${war_home}

        cp -rf  ${war_home}/${war}  ${deploy}
        chmod -R 775 ${deploy}/${war}
        cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
        cp ${deploy_backup}/${war}/${conf}/${log}  ${deploy}/${war}/${conf}/${log}
        cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
        cp ${deploy_backup}/${war}/${class}/${jcc} ${deploy}/${war}/${class}/${jcc}
        echo " ${war} 发布完成！"
        ;;
tdadmin|trade)

	cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	license=client_license.dat
	ares=ares-app-config.xml

	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	cp ${deploy_backup}/${war}/${conf}/${log}  ${deploy}/${war}/${conf}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	cp ${deploy_backup}/${war}/${class}/${license} ${deploy}/${war}/${class}/${license}
	echo " ${war} 发布完成！"
	;;

ar)
	cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	#server=server.properties
	log=log4j.properties
	ares=ares-app-config.xml
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	#cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	cp ${deploy_backup}/${war}/${class}/${log}  ${deploy}/${war}/${class}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	echo " ${war} 发布完成！"
	;;


ucweb|ucadmin|eclp)

	cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	ares=ares-app-config.xml
	msg=msg.properties
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
        
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${class}/${server} ${deploy}/${war}/${class}/${server}
	cp ${deploy_backup}/${war}/${class}/${log}  ${deploy}/${war}/${class}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	cp ${deploy_backup}/${war}/${class}/${msg} ${deploy}/${war}/${class}/${msg}
	echo " ${war} 发布完成！"
	;;
ucas)

	cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	ares=ares-app-config.xml
	msg=msg.properties
	biz=bizmapping.properties
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${class}/${server} ${deploy}/${war}/${class}/${server}
	cp ${deploy_backup}/${war}/${class}/${log}  ${deploy}/${war}/${class}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	cp ${deploy_backup}/${war}/${class}/${msg} ${deploy}/${war}/${class}/${msg}
	cp ${deploy_backup}/${war}/${class}/${biz} ${deploy}/${war}/${class}/${biz}
	echo " ${war} 发布完成！"
	;;
cmsadmin)

	cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	ares=ares-app-config.xml
	msg=msg.properties
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
        
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${class}/${server} ${deploy}/${war}/${class}/${server}
	cp ${deploy_backup}/${war}/${class}/${log}  ${deploy}/${war}/${class}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	#cp ${deploy_backup}/${war}/${class}/${msg} ${deploy}/${war}/${class}/${msg}
	echo " ${war} 发布完成！"
	;;
	
wh |wr| wradmin)
cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=*.properties
	
	ares=ares-app-config.xml
	msg=msg.properties
	#web=web.xml
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp  -rf ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	
	echo " ${war} 发布完成！"
	;;
b2b2c)

        cd ${deploy}
        mv $war ${deploy_backup}
        class=webapp/WEB-INF/classes
        conf=webapp/WEB-INF/conf/spring/web
        server=server.properties
        log=log4j.properties
        jdbc=jdbc.properties
        memcached=memcached.properties
	banksetting=banksetting.xml
	banktuikuang=banktuikuang.xml
        #cd ${fabu_home}/${date}_wars
        cd ${war_home}

        cp -rf  ${war_home}/${war}  ${deploy}
        chmod -R 775 ${deploy}/${war}
        cp ${deploy_backup}/${war}/${classes}/${server} ${deploy}/${war}/${classes}/${server}
        cp ${deploy_backup}/${war}/${classes}/${log}  ${deploy}/${war}/${classes}/${log}
        cp ${deploy_backup}/${war}/${classes}/${jdbc}  ${deploy}/${war}/${classes}/${jdbc}
        cp ${deploy_backup}/${war}/${classes}/${memcached}  ${deploy}/${war}/${classes}/${memcached}
        cp ${deploy_backup}/${war}/${conf}/${banksetting} ${deploy}/${war}/${conf}/${banksetting}
        cp ${deploy_backup}/${war}/${conf}/${banktuikuang} ${deploy}/${war}/${conf}/${banktuikuang}
        echo " ${war} 发布完成！"
        ;;
settles)

        cd ${deploy}
        mv $war ${deploy_backup}
        class=webapp/WEB-INF/classes
        conf=webapp/WEB-INF/conf/spring/web
        server=server.properties
        log=log4j.properties
        jdbc=jdbc.properties
        memcached=memcached.properties
	banksetting=banksetting.xml
	#cd ${fabu_home}/${date}_wars
        cd ${war_home}

        cp -rf  ${war_home}/${war}  ${deploy}
        chmod -R 775 ${deploy}/${war}
        cp ${deploy_backup}/${war}/${classes}/${server} ${deploy}/${war}/${classes}/${server}
        cp ${deploy_backup}/${war}/${classes}/${log}  ${deploy}/${war}/${classes}/${log}
        cp ${deploy_backup}/${war}/${classes}/${jdbc}  ${deploy}/${war}/${classes}/${jdbc}
        cp ${deploy_backup}/${war}/${classes}/${memcached}  ${deploy}/${war}/${classes}/${memcached}
        cp ${deploy_backup}/${war}/${conf}/${banksetting} ${deploy}/${war}/${conf}/${banksetting}
        echo " ${war} 发布完成！"
        ;;
payment)

        cd ${deploy}
        mv $war ${deploy_backup}
        class=webapp/WEB-INF/classes
        conf=webapp/WEB-INF/conf
        server=server.properties
        log=log4j.properties
        jdbc=jdbc.properties
	banksetting=spring/web/banksetting.xml
	bankconfig=bank/bankconfig.xml
        #cd ${fabu_home}/${date}_wars
        cd ${war_home}

        cp -rf  ${war_home}/${war}  ${deploy}
        chmod -R 775 ${deploy}/${war}
        cp ${deploy_backup}/${war}/${classes}/${server} ${deploy}/${war}/${classes}/${server}
        cp ${deploy_backup}/${war}/${classes}/${log}  ${deploy}/${war}/${classes}/${log}
        cp ${deploy_backup}/${war}/${classes}/${jdbc}  ${deploy}/${war}/${classes}/${jdbc}
        cp ${deploy_backup}/${war}/${conf}/${banksetting} ${deploy}/${war}/${conf}/${banksetting}
        cp ${deploy_backup}/${war}/${conf}/${bankconfig} ${deploy}/${war}/${conf}/${bankconfig}
        echo " ${war} 发布完成！"
        ;;
plumb)

	cd ${deploy}
	mv $war ${deploy_backup}
	#class=webroot/WEB-INF/classes
	conf=webroot/WEB-INF/conf
	server=server.properties
	log=log4j.properties
	#ares=ares-app-config.xml
	#msg=msg.properties
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
        
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	cp ${deploy_backup}/${war}/${conf}/${log}  ${deploy}/${war}/${conf}/${log}
	#cp ${deploy_backup}/${war}/${conf}/${ares} ${deploy}/${war}/${conf}/${ares}
	#cp ${deploy_backup}/${war}/${conf}/${msg} ${deploy}/${war}/${conf}/${msg}
	echo " ${war} 发布完成！"
	;;
#现货连续
aluminum|copper|platinum|silver)
cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	msg=msg.properties
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	cp ${deploy_backup}/${war}/${conf}/${log}  ${deploy}/${war}/${conf}/${log}
	echo " ${war} 发布完成！"
	;;
gold|lead|zinc)
cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	ares=ares-app-config.xml
	msg=msg.properties
	license=client_license.dat
        #cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	cp ${deploy_backup}/${war}/${conf}/${log}  ${deploy}/${war}/${conf}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	cp ${deploy_backup}/${war}/${class}/${license} ${deploy}/${war}/${class}/${license}
        echo " ${war} 发布完成！"
	;;

cmsweb|*)
cd ${deploy}
	mv $war ${deploy_backup}
	class=WEB-INF/classes
	conf=WEB-INF/conf
	server=server.properties
	log=log4j.properties
	ares=ares-app-config.xml
	msg=msg.properties
	#cd ${fabu_home}/${date}_wars
	cd ${war_home}
	
	cp -rf  ${war_home}/${war}  ${deploy}
	chmod -R 775 ${deploy}/${war}
	cp ${deploy_backup}/${war}/${conf}/${server} ${deploy}/${war}/${conf}/${server}
	cp ${deploy_backup}/${war}/${conf}/${log}  ${deploy}/${war}/${conf}/${log}
	cp ${deploy_backup}/${war}/${class}/${ares} ${deploy}/${war}/${class}/${ares}
	echo " ${war} 发布完成！"
	;;

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
APPTOM="/home/$USER/tomcats/$(ls ~/tomcats | grep  "$war"|grep -v bak)"
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
