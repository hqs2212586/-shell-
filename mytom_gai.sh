#!/bin/bash
USER_HOME=$HOME
DEPLOY_HOME=${USER_HOME}/deploy
TOMCAT_HOME=${USER_HOME}/tomcats

for app in $(ls ${USER_HOME}/deploy)
do
	echo $app
done

if [ "$1X" = "-iX" ]
then
	v1=i
	vd=d
else
	v1=n
	vp=p
fi
echo $v1 $v2
#docBase
#sed -r${v1} "/<\/Context>/s#(<Context.*</Context>)#\<\!\-\-\1\-\->#${vp}"  $(find ${TOMCAT_HOME} -name "server.xml")

#JVM
sed -${v1} "/^JAVA_OPTS/${vd}${vp}" $(find ./ -name "catalina.sh")
sed -${v1} '/^# OS specific support/i JAVA_OPTS=\"-Xms256m -Xmx512m -Xss1024K -XX:PermSize=128m -XX:MaxPermSize=256m -Djava.awt.headless=true\"'  $(find ${TOMCAT_HOME} -name "catalina.sh")
