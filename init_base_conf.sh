#!/bin/bash 

func_mkdir(){
        mkdir -p /alidata/www/logs/tengine/ /alidata/www/logs/jetty/ /alidata/www/apps/ /alidata/www/logs/java/ /alidata/www/logs/aliyun.com/ /alidata/www/wwwroot/ /alidata/www/tmp/ /alidata/www/cache/ /alidata/www/data/ /alidata/www/package /alidata/www/backup /alidata/bin/ /alidata/conf/ 
        chown -R www:www /alidata/www /home/www 
        chown -R appadmin:appadmin /alidata/www/wwwroot /alidata/www/apps /alidata/www/backup /alidata/www/package
        chmod 777 /alidata/www/tmp/ /alidata/www/cache/ /alidata/www/data/ /alidata/www/logs/ /alidata/conf/
}

func_tengine(){
    mkdir -p /alidata/www/logs/tengine/
    mkdir -p /etc/tengine/cert
    chmod 777 /alidata/www/logs/tengine/
    chmod 755 /var/log/tengine
    touch /usr/share/tengine/html/status.html                    
    
# /etc/init.d/tengine stop
#   pkill -9 tengine

#    rm -fr /etc/tengine/conf.d/*.conf
#    cp -f /alidata/conf/tengine*.conf /etc/tengine/conf.d/

#   /etc/init.d/tengine start
#   /sbin/chkconfig --add tengine
#   /sbin/chkconfig tengine on

    echo "config tengine ok"

}

func_jetty(){
    ln -sfn /alidata/www/wwwroot /var/lib/jetty/webapps
    ln -sfn /usr/share/jetty/etc /etc/jetty 
    ln -sfn /alidata/www/wwwroot /usr/share/jetty/webapps/wwwroot
    ln -sfn /usr/share/jetty/bin/jetty.sh /usr/bin/jetty
   
    rm -rf /usr/share/jetty/logs
    ln -sfn /alidata/www/logs/jetty /usr/share/jetty/logs
    chown www:www /usr/share/jetty/logs -R

    #MEM=`free -m | grep 'Mem:' | awk '{print \$2}'`
    #MEM=8196
    #MEM1=`echo "$MEM * 2 / 3" | bc -l | awk -F\. '{print $1}'`
    #MEM2=`echo "$MEM / 4" | bc -l | awk -F\. '{print $1}'`
    #sed -i "s/5332m/${MEM1}m/g" /etc/jetty/start.ini
    #sed -i "s/1999m/${MEM2}m/g" /etc/jetty/start.ini
    
    echo "config jetty ok"
}
func_tomcat(){
    mkdir -p /alidata/www/logs/tomcat7 /alidata/www/apps/tomcat7
    chown -R tomcat.tomcat /alidata/www/logs/tomcat7 /usr/share/tomcat7/logs
    chmod 755 /home/tomcat
    chmod 755 /home/www
    chown -R appadmin.appadmin /alidata/www/apps/tomcat7
    rm -rf /var/log/tomcat7 /var/lib/tomcat7/webapps
    ln -sfn /alidata/www/logs/tomcat7 /var/log/tomcat7
    ln -sfn /alidata/www/apps/tomcat7 /var/lib/tomcat7/webapps
    mkdir -p /alidata/www/data/tomcat7
    mkdir -p /alidata/www/cache/tomcat7
    mkdir -p /alidata/www/tmp/tomcat7
    chown tomcat.tomcat /alidata/www/data/tomcat7
    chown tomcat.tomcat /alidata/www/cache/tomcat7
    chown tomcat.tomcat /alidata/www/tmp/tomcat7
    #MEM=`free -m | grep 'Mem:' | awk '{print \$2}'`
    #MEM=8196
    #MEM1=`echo "$MEM * 2 / 3" | bc -l | awk -F\. '{print $1}'`
    #MEM2=`echo "$MEM / 4" | bc -l | awk -F\. '{print $1}'`
    #sed -i "s/5332/$MEM1/g" /etc/tomcat7/tomcat7.conf
    #sed -i "s/1999/$MEM2/g" /etc/tomcat7/tomcat7.conf
    
    echo "config tomcat ok"
}
func_mkdir
func_tengine
func_jetty
func_tomcat
exit 0
