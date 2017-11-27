书写一个脚本
1、该脚本应当有交互功能
2、该脚本用于备份系统目录
3、需要给予用户提示，提示用户应当输入目录|文件名 read -p
4、判断用户要备份的文件是否存在，如果不存在则告知用户，并输出相应错误  test 
5、判断用户要备份的目标目录是否存在，如果该目录不存在，则需要问用户是否创建，如果该文件名已经存在，则需要问用户是否重命名该目录 test  if 
6、脚本中，需要返回相应的退出状态

#!/bin/bash
read -p "Please  INput  which dir or  file you want to backup:  " FILE
if  [ ! -e $FILE ] ;then
echo "INput file not Found"
exit 6
fi

read -p  "Please Input a dir you want to use: " DIR
if [ ! -d $DIR ];then
   if [ -f $DIR ];then
        echo "$DIR is a File"
        read -p "Rename $DIR? <y/n>" IN
        A=$(echo $IN|tr 'A-Z' 'a-z')
        case $A in
            y)
                mv  $DIR $DIR-bak
                echo "New File name $DIR-bak "
                mkdir -p $DIR
                cp -r $FILE $DIR
                if [ $? = 0 ] ;then
                echo "backup Success"
                else
                echo "Backup faile" 
                exit10
                fi
            ;;
            n)
                exit 6
            ;;
        esac
     else
        mkdir -p $DIR
        cp -r $FILE $DIR
        if [ $? = 0 ] ;then
         echo "backup Success"
        else
        echo "Backup faile" 
        exit10
        fi

    fi
else
        cp -r $FILE $DIR
        if [ $? = 0 ] ;then
         echo "backup Success"
        else
        echo "Backup faile" 
        exit10
        fi
fi