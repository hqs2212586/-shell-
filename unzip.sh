#!/bin/bash

#变量定义
DATE=$(date +%Y%m%d)
DEPLOY=/home/hbets/share/fabu
FABU_HOME=/home/hbets/share/fabu


declare DEPDIR=${DEPLOY}/${DATE}
declare APPS=(eclp uc-as ucweb ucadmin hps-as hps-admin hps-webapp-bak gold
copper aluminum jres-ar lead platinum silver zinc chengdudao chongqingdao dalidao broker 
genshan msg munandao wh base baseadmin wulin fengshan trade )
declare ERRLOG=ErrUnzip_${DATE}.log


# 使用说明
usage()
{	
	echo
	echo " 使用说明:"
	echo 
	echo "	[-a[app]]	打印合法APP内容"
	echo "	[-h[help]]	打印使用说明"
#	echo "	执行脚本$0"
	echo "	使用前需确认变量FABU_HOME(默认WAR包路径),DEPDIR(默认解压路径),APPS(合法APP)"
	echo
}

#检查传入APP_NAME是否存在于APPS中，无视war包名称及APPS的大小写，存在返回，不存在返回1
IsApp()
{
	local APP_NAME=`echo  $1 | tr 'A-Z' 'a-z' | sed 's/[^A-Za-z]//g'`
	if [ -n "$APP_NAME" ]; then
		len=${#APPS[*]}
		i=0
		while [ $i -lt $len ]
		do
			local APP_REAL=`echo  ${APPS[$i]} | tr 'A-Z' 'a-z' | sed 's/[^A-Za-z]//g' `
		        if [ "$APP_NAME" = "${APP_REAL}" ]; then
		                break
		        fi
		        let i++
		done
		if [ $i -ge $len ]; then
		        echo -e " Error: ${APP_NAME}非法！\n"
		        return 255
		else
			return $i
		fi
	fi
}

#解压，入参：$1=工程解压路径，$2=WAR包路径
unzip_war()
{
	local APP_DIR=$1
	local WAR_PATH=$2

	echo -e " ${WAR} 开始解压..."
	unzip -d ${APP_DIR} ${WAR_PATH} 2>${ERRLOG} 1>/dev/null

	#解压校验
	if [ $? == "0" ]
	then
		echo -e "\033[34m ${WAR_PATH} 解压成功，路径：${APP_DIR}\033[0m \n"
	else
		echo -e "\033[31m Error: ${WAR_PATH} 解压报错，查看`pwd`/${ERRLOG}\033[0m \n\a"
		rm -rf ${APP_DIR}	
	fi
}



#打印说明
if [ "$1" == "-h" -o "$1" == "-help" ]; then
	usage
	exit 0
fi
#打印APPS
if [ "$1" == "-a" -o "$1" == "-app" ]; then
	echo -e "\n 合法APPS：${APPS[*]}\n"
	exit 0 
fi

WARS_DIR=${FABU_HOME}/${DATE}

#获取war包名称
#wars=`ls ${WARS_DIR}/*.war | awk -F/ '{print $NF }'`

#wars=`ls ${WARS_DIR}/*.war  | awk -F/ '{print $NF }' | awk -F "-|_" '{print $1}'`


for WAR_PATH in ${WARS_DIR}/*.war
do
	
	APP_NAME=`basename ${WAR_PATH} | awk -F "[0-9]" '{print $1}' | awk -F . '{print $1}'`
#        echo 1
#	echo $APP_NAME
#	echo 1
#	continue	
	#检查输入的工程名是否合法
	IsApp ${APP_NAME}
	FLAG=$?
	
	#解压
	if [ ${FLAG} != "255" ]
	then
		
		WAR_DIR="${DEPDIR}/${APPS[${FLAG}]}"
		unzip_war ${WAR_DIR} ${WAR_PATH}
	else
		echo -e " Error: ${APP_NAME}非法，不会被解压，请重新确认！\n\a"
	fi
done























#校验错误日志
if [ -s ${ERRLOG} ]
then
	echo -e " 需要查看`pwd`/${error} \a\n"
	usage
else
	rm -rf `pwd`/${ERRLOG}
fi

echo -e " 脚本结束!\a\n"

