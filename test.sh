#!/bin/sh

for((i=21;i<=145;++i)) 
do
    echo "iptables -A INPUT -s  134.96.181.$i -j ACCEPT" >> /tmp/sujing
done

for i in cat `/tmp/sujing` 
do 
  /usr/bin/expect <<-EOF
   set ip $i  
   set password admin123
   set timeout 10  
   spawn ssh root@$i
   expect {  
   "*yes/no" { send "yes\r"; exp_continue}  
   "*password:" { send "$password\r" }  
   }  
   expect "#*"  
   send "iptables -A INPUT -s  134.96.181.$i -j ACCEPT\r"  
   send  "exit\r"  
   expect eof  
   EOF
   
done
