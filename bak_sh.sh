#!/bin/bash
JAVA_HOME=/usr/local/java/jdk1.6.0_33
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin


echo "备份war开始..."
# 打印使用说明
usage()
{
    echo "使用说明"
    echo "    [-h[help]]  打印使用说明"
    echo " 要备份那个IP的 tomcat部署包，就直接后面带上IP地址 "
}
if [ "$1" = "-h" -o "$1" = "-help" ]; then
    usage
    exit 0
fi


#路径变量定义

 

                echo "新建备份目录"
             cd /home/hbets/backup
	        

                
                DATEDIR=$(date +%Y%m%d)
                #date +%Y%m%d
                mkdir $DATEDIR
                echo "新建备份目录完成"
                cd    $DATEDIR
                echo "开始备份本地的war"
                cp  -rf  /home/hbets/deploy/* ./

	        ls
               
                 
             
echo "备份结束"

