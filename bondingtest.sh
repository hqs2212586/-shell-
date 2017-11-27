#!/bin/bash
# 加载bonding模块
modprobe  bonding

# 命令的退出状态
if [ $? != 0 ] ;then
	echo '`bonding`模块Error'
fi

echo 'Kernel Check ok'
echo 'Config NetworkManager'
systemctl stop NetworkManager.service 
systemctl disable NetworkManager
systemctl mask NetworkManager

# 网卡接口模式
echo 'collecting network info'
v1=$(ifconfig | grep UP | tail -3 | head -1 | awk -F: '{print $1}')
v2=$(ifconfig | grep UP | tail -2 | head -1 | awk -F: '{print $1}')

echo 'Create network-scripts files for '$v1, $v2
cat > /etc/sysconfig/network-scripts/ifcfg-enoa << END
DEVICE=eno33554992
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
MASTER=bond0
SLAVE=YES
END

cat > /etc/sysconfig/network-scripts/ifcfg-enob << END
DEVICE=eno50332216
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
MASTER=bond0
SLAVE=yes
END

cat > /etc/sysconfig/network-scripts/ifcfg-bond0 << END
DEVICE=bond0
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
BONDING_OPTS="mode 1 miimon 100"
IPADDR=192.168.240.138
NETMASK=255.255.255.0
END

sed -i "/DEVICE=/c\DEVICE=$v1" ifcfg-enoa
sed -i "/DEVICE=/c\DEVICE=$v2" ifcfg-enob
service network restart
