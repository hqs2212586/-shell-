1、ADS扩容
1.1 准备工作,参考《扩容基础环境搭建》
a.装机
　将新增的机器，安装好操作系统。装机模板、分区等信息请参照原先ADS_cs节点的装机任务。
  添加到天基

1.1.1检查必备软件是否安装，版本是否与未重装机器一致：

rpm -qa |egrep "apsara-dayu|chenxiang-agent|apsara-netqos|cgroup"

软件名分别如下：
apsara-dayu
apsara-dayu-watchdog
chenxiang-agent
apsara-netqos
libcgroup
cgroup.config

如版本对不上可使用如下命令
pssh -h $ads_iplist -i 'yum -y remove 包名'		###卸载命令
pssh -h $ads_iplist -i 'yum -y install 包名 -b test'	###安装命令	


确认集群内未重装机器的java版本，对比刚装机器的java版本，确保与原先一致。

ADS使用的java版本，以该命令看到的版本为准：一般为jdk 1.8
/opt/taobao/java/bin/java -version

如未装,登录ads飞天集群的apsara_ag,执行以下命令,$ads_iplist表示写有扩容机器ip的文件
prsync -h $ads_iplist /opt/aliyun/app/jdk/resources/ali-jdk-1.8.0_66-94.el5.x86_64.rpm /tmp
pssh -h $ads_iplist "rpm -q ali-jdk || sudo rpm -i /tmp/ali-jdk-1.8.0_66-94.el5.x86_64.rpm --force" 
在拷贝之前，先打通ads_ag和apsara_ag到各个物理机的通道
打通通道
　打通ag与新增机器的admin通道。
  到dms_ag机器
  sudo su root
  scp $ads_ag_ip:/home/amin/.ssh/authorized_keys /tmp/     ##把ads_ag的私钥拷到dms_ag上
  chown admin:admin /tmp/authorized_keys
  pscp -h iplist -A /tmp/authorized_keys /home/amin/.ssh/authorized_keys		##把私钥覆盖到待扩容的机器上


如果是重新装机，缩扩容的操作，跳过1.2的步骤
1.2 修改Quota>
a.查看当前quota值
	登录ads_ag
  r quota 
  该命令查看集群quota状态，得到扩容前CPU和MEM 的quota CPU_Quota_Old/MEM_Quota_Old
  输出结果如下供参考，设置的值为InitQuoa的值(static的值)，ScaleRatio字段为当前使用了多少Quota：
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
|Account|Alias          |SchedulerType  |Strategy |InitQuota                |ScaledQuota        |ScaleRatio         |Runtime            |UsageInfo                |

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

|       |               |               |         |      |CPU:10000000      |                   |                   |                   |         |CPU:0          |

|       |               |               |         |Static|------------------|CPU:471200         |CPU:10000000       |CPU:0              |Used     |---------------|

|       |               |               |         |      |Mem:100000000     |                   |                   |                   |         |Mem:0          |

|1      |ifb            |Fifo           |Preempt  |-------------------------|-------------------|-------------------|-------------------|-------------------------|

|       |               |               |         |      |CPU:100           |                   |                   |                   |         |CPU:0          |

|       |               |               |         |Min   |------------------|Mem:17421086       |Mem:100000000      |Mem:12718080       |Available|---------------|

|       |               |               |         |      |Mem:500           |                   |                   |                   |         |Mem:0          |

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
b.查看当前计算节点个数,也可以参考R表中的cs节点数
　search pangu_chunkserver |wc -l 
c.计算新的cpu和mem quota，其中CPU_Quota/MEM_Quota的值参考initQuota的static值，计算方法如下：
　CPU_Quota_New=(新扩容机器数+集群已有计算节点个数)/ 集群已有计算节点个数 * 1.2 * CPU_Quota_Old
　MEM_Quota_New=(新扩容机器数+集群已有计算节点个数)/ 集群已有计算节点个数 * 1.2 * MEM_Quota_Old
d.设置新quota
　r setquota -i ${Account} -a ${Alias} -s ${CPU_Quota_New} ${MEM_Quota_New}
　Account、Alias为上图中相应字段的值

1.3 新增飞天角色
打印tubo ip
查看原有tubo的角色
search tubo　>tubo_ip
for i in `cat tubo_ip`;do me -i $i;done

增加新增的chunkserver飞天角色
在apsara_ag上执行：
/home/admin/dayu/install/role_resize --set_role="${role}" add /tmp/add.list
查看打印的日志“failed值为空”表示角色新增成功

注意：
  双引号中 ${role} 的内容，需根据现场环境现有计算节点的角色来设定，
　先通过命令：me -i  ${odps_cs_ip}   查看环境中现有计算节点的角色，一般所有计算节点的角色都一样。
　再根据得到的角色，进行格式重新编辑：只有角色名（不含Role_前缀，不含集群名称），角色之间用逗号隔开。
例如：
  通过me命令查到的当前cs角色信息如下：
    "role_ads_cs|role_deploy_agent|role_pangu_chunkserver|role_shennong_inspector|role_tubo|role_watch_dog|rol e_xihe_worker|clusterName_XXXX"
  那么,--set_role="${role}",引号中的内容如下写法：
    "ads_cs,deploy_agent,pangu_chunkserver,shennong_inspector,tubo,watch_dog,xihe_worker"
如下：
/home/admin/dayu/install/role_resize --set_role="N36.22,deploy_agent,pangu_chunkserver,shennong_inspector,tubo,watch_dog,xihe_worker" add /tmp/add.list

1.4 启动飞天
pssh -h /tmp/add.list -i "home/admin/dayu/bin/super-apsarad start"

1.5 检查飞天状态
pssh –h  /tmp/add.list -i "/home/admin/dayu/bin/apsarad status"
若飞天状态正常，扩容完成。

1.6 确认新扩容机器盘古状态为NORMAL
puadmin lscs |grep tcp

1.7 确认新扩容的机器,总资源能看到
r ttrl

1.8 确认新扩容的机器是否达标
r tbnl

1.8.1 如新扩容的机器没有打标
根据旧机器r tbnl的值，这个值可参考现有环境的顺序重新编写，冒号两边必须双引号。
vi label_n35
{
    "fuxiServiceLable":"N35.22",
    "gallardoRM":"gallardoRM",
    "mergeNode":"mergeNode",
    "updateNode":"updateNode"
    "localNode":"localNode"
}

1.8.2 给新机器打标
python /apsara/deploy/rpc_wrapper/set_tubo_node_label_new.py -r default -i /home/admin/$ip_file -n /home/admin/$label_file -u abc

1.8.3 检查新机器打标是否成功
	r tbnl	

2. 绑核验证
 2.1 验证pangu_chunkserver进程绑核
 得到pangu_chunkserver进程号pid
 ps -ef |grep pangu 
 查看绑核是否正确,list: 2-6为正确
 taskset -cp $pid 
 批量验证，如下：
 pssh -h /tmp/add.list -i 'taskset -cp `pidof /apsara/pangu_chunkserver/pangu_chunkserver`' 
 
 2.2 验证tubo进程绑核
 得到tubo进程号pid
 ps -ef |grep /apsara/tubo/tubo
 查看绑核是否正确,list: 7-55为正确
 taskset -cp $pid
 批量验证，如下：
	pssh -h /tmp/add.list -i 'taskset -cp `pidof /apsara/tubo/tubo`' 
 
 2.3 验证网络绑核,返回为空则未绑核
 me -l | grep CLUSTER_CGROUP_CPU_CONFIG | grep CPUSET 
 批量验证，如下：
	pssh -h /tmp/add.list -i 'me -l | grep CLUSTER_CGROUP_CPU_CONFIG | grep CPUSET'
 
 2.3 如检查pangu_chunkserver,tubo绑核不正确
 	
 	pangu_chunkserver手动绑核
  search pangu_chunkserver >/tmp/csips
  pssh -h /tmp/csips "ps auxf | grep /apsara/pangu_chunkserver/pangu_chunkserver | grep  -v grep  | awk '{print $2}'  | xargs -i  /bin/cgclassify -g cpuset:/apsara/pangu/chunkserver  --sticky {}" 
	
 	tubo手动绑核
  /home/admin/dayu/bin/search tubo >/tmp/tuboips
  pssh  -h /tmp/tuboips "ps auxf | grep /apsara/tubo/tubo  | grep  -v grep  | awk '{print $2}'  | xargs -i  sudo /bin/cgclassify -g cpuset:/apsara/tubo —sticky {}"
 	
 	
 2.4验证绑核
	检查pangu_chunkserver绑核
	taskset -cp $pid
	检查tubo绑核
  taskset -cp $pid
  如验证还不正确,看《ads集群绑核修复》步骤
	
	
3.更新R表，更新CMDB。
3.1.更新R表
	将机器新增至R表中，天目上重载配置
3.2.更新armory
	新增机器制作一份armory表上传至armory并把设备设置为online状态，完成后进入alimonitor查看服务器监控状态。
3.3.更新CMDB
	3.3.1.可用脚本添加，示例为添加vip信息，添加cs物理机信息，去cs的相关字段替换对应下列字段
	cmdbClient.py put /ram=vip '[{"name": "master-api", "values": {"nc_list":"[\"10.12.218.32\"]","lb_id": "ram-master.pcloud.ga","vip_ip":"--","vport": "ram-master.pcloud.ga","srcport":"--",}}]'
	3.3.2.另一种方法，下载原cmdb上节点的信息，进行编辑，在上传到至cmdb中。
	
扩容完成

备注：
cs节点若有扩容失败，或者有故障节点需做下线操作，参考如下：
同1.3新增飞天角色，缩容时移除角色，当然此操作只在新扩容机器上操作，如节点由数据请ADS产品的同学提供更加详细的下线方案：
/home/admin/dayu/install/role_resize remove /tmp/add.list