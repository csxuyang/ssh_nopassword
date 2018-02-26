#此脚本慎用，除非你知道将要发生什么，本人不承担此脚本引发的各种问题的责任...

yum clean all
#rm -rf /var/lib/ambari-agent 
#ambari 安装失败，重新安装脚本
#1.删除hdp.repo和hdp-util.repo
cd /etc/yum.repos.d/
rm -rf hdp*
rm -rf HDP*
#rm -rf ambari*
#2.删除安装包
#用yum list installed | grep HDP来检查安装的ambari的包
yum remove -y  sqoop.noarch 
yum remove -y  lzo-devel.x86_64 
yum remove -y  hadoop-libhdfs.x86_64 
yum remove -y  rrdtool.x86_64 
yum remove -y  hbase.noarch 
yum remove -y  pig.noarch 
yum remove -y  lzo.x86_64 
yum remove -y  ambari-log4j.noarch 
yum remove -y  oozie.noarch 
yum remove -y  oozie-client.noarch 
yum remove -y  gweb.noarch 
yum remove -y  snappy-devel.x86_64 
yum remove -y  hcatalog.noarch 
yum remove -y  python-rrdtool.x86_64 
yum remove -y  nagios.x86_64 
yum remove -y  webhcat-tar-pig.noarch 
yum remove -y  snappy.x86_64 
yum remove -y  libconfuse.x86_64   
yum remove -y  webhcat-tar-hive.noarch 
yum remove -y  ganglia-gmetad.x86_64 
yum remove -y  extjs.noarch 
yum remove -y  hive.noarch 
yum remove -y  hadoop-lzo.x86_64 
yum remove -y  hadoop-lzo-native.x86_64 
yum remove -y  hadoop-native.x86_64 
yum remove -y  hadoop-pipes.x86_64 
yum remove -y  nagios-plugins.x86_64 
yum remove -y  hadoop.x86_64 
yum remove -y  zookeeper.noarch     
yum remove -y  hadoop-sbin.x86_64 
yum remove -y  ganglia-gmond.x86_64 
yum remove -y  libganglia.x86_64 
yum remove -y  perl-rrdtool.x86_64
yum remove -y  epel-release.noarch
yum remove -y  compat-readline5*
yum remove -y  fping.x86_64
yum remove -y  perl-Crypt-DES.x86_64
yum remove -y  exim.x86_64
yum remove -y ganglia-web.noarch
yum remove -y perl-Digest-HMAC.noarch
yum remove -y perl-Digest-SHA1.x86_64
yum remove -y bigtop-jsvc.x86_64
yum remove -y hadoop*
yum remove -y storm*
yum remove -y ranger*
yum remove -y hdp-select*
yum remove -y accumulo*
yum remove -y slider*
yum remove -y zookeeper*
yum remove -y atlas*
yum remove -y falcon*
yum remove -y kafka*
yum remove -y bigtop-tomcat*
yum remove -y hbase_*
yum remove -y smartsense-hst*
yum remove -y spark*
yum remove -y spark2*
yum remove -y atlas-metadata*
yum remove -y druid*
yum remove -y datafu*
yum remove -y flume*
yum remove -y hive*
yum remove -y hue*
yum remove -y livy*
yum remove -y kafka*
yum remove -y mahout*
yum remove -y phoenix*
yum remove -y superset*
yum remove -y tez*
yum remove -y zeppelin*
yum remove -y hadooplzo-native*
yum remove -y openblas*
yum remove -y snappy*


#3.删除快捷方式
cd /etc/alternatives
rm -rf hadoop-etc
rm -rf zookeeper-conf
rm -rf hbase-conf
rm -rf hadoop-log
rm -rf hadoop-lib
rm -rf hadoop-default
rm -rf oozie-conf
rm -rf hcatalog-conf
rm -rf hive-conf
rm -rf hadoop-man
rm -rf sqoop-conf
rm -rf hadoop-conf
rm -rf /tmp/*
#4.删除用户
userdel nagios
userdel hive
userdel ambari-qa
userdel hbase
userdel oozie
userdel hcat
userdel mapred
userdel hdfs
userdel rrdcached
userdel zookeeper
#userdel mysql
userdel sqoop
userdel puppet
userdel yarn
userdel tez
userdel hadoop
userdel knox
userdel storm
userdel falcon
userdel flume
userdel nagios
userdel admin
userdel postgres
userdel  hdfs
userdel  zookeeper
userdel hbase
userdel kafka
userdel atlas
userdel ams
userdel accumulo
userdel mahout
userdel spark
userdel zookeeper
userdel hdfs
userdel yarn
userdel hbase
userdel kafka
userdel hive
userdel oozie

#5.删除文件夹
rm -rf /hadoop
rm -rf /etc/hadoop
rm -rf /etc/hbase
rm -rf /etc/hcatalog
rm -rf /etc/hive
rm -rf /etc/ganglia
rm -rf /etc/nagios
rm -rf /etc/oozie
rm -rf /etc/sqoop
rm -rf /etc/zookeeper
rm -rf /etc/kafka
rm -rf /etc/mahout
rm -rf /etc/spark
rm -rf /etc/pig
rm -rf /etc/phoenix
rm -rf /etc/accumulo
rm -rf /etc/atlas
rm -rf /var/run/kafka
rm -rf /var/run/spark
rm -rf /var/run/accumulo
rm -rf /var/run/ambari-metrics-monitor
rm -rf /var/log/knox
rm -rf /var/log/kafka
rm -rf /var/log/spark
rm -rf /var/log/accumulo
rm -rf /kafka-logs
rm -rf /var/run/ambari-metrics-collector
rm -rf /var/run/atlas
rm -rf /var/log/webhcat
rm -rf /var/log/atlas
rm -rf /var/lib/atlas
rm -rf /var/run/knox
rm -rf /var/run/hadoop
rm -rf /var/run/hbase
rm -rf /var/run/hive
rm -rf /var/run/ganglia
rm -rf /var/run/nagios
rm -rf /var/run/oozie
rm -rf /var/run/zookeeper
rm -rf /var/log/hadoop
rm -rf /var/log/hbase
rm -rf /var/log/hive
rm -rf /var/log/nagios
rm -rf /var/log/oozie
rm -rf /var/log/zookeeper
rm -rf /usr/lib/hadoop
rm -rf /usr/lib/hbase
rm -rf /usr/lib/hcatalog
rm -rf /usr/lib/hive
rm -rf /usr/lib/oozie
rm -rf /usr/lib/sqoop
rm -rf /usr/lib/zookeeper
rm -rf /var/lib/hive
rm -rf /var/lib/ganglia
rm -rf /var/lib/oozie
rm -rf /var/lib/zookeeper
rm -rf /var/tmp/oozie
rm -rf /tmp/hive
rm -rf /tmp/nagios
rm -rf /tmp/ambari-qa
rm -rf /tmp/sqoop-ambari-qa
rm -rf /var/nagios
rm -rf /hadoop/oozie
rm -rf /hadoop/zookeeper
rm -rf /hadoop/mapred
rm -rf /hadoop/hdfs
rm -rf /tmp/hadoop-hive
rm -rf /tmp/hadoop-nagios
rm -rf /tmp/hadoop-hcat
rm -rf /tmp/hadoop-ambari-qa
rm -rf /tmp/hsperfdata_hbase
rm -rf /tmp/hsperfdata_hive
rm -rf /tmp/hsperfdata_nagios
rm -rf /tmp/hsperfdata_oozie
rm -rf /tmp/hsperfdata_zookeeper
rm -rf /tmp/hsperfdata_mapred
rm -rf /tmp/hsperfdata_hdfs
rm -rf /tmp/hsperfdata_hcat
rm -rf /tmp/hsperfdata_ambari-qa
rm -rf /etc/flume
rm -rf /etc/storm
rm -rf /etc/hive-hcatalog
rm -rf /etc/tez
rm -rf /etc/falcon
rm -rf /var/run/flume
rm -rf /var/run/storm
rm -rf /var/run/webhcat
rm -rf /var/run/hadoop-yarn
rm -rf /var/run/hadoop-mapreduce
rm -rf /var/log/flume
rm -rf /var/log/storm
rm -rf /var/log/hadoop-yarn
rm -rf /var/log/hadoop-mapreduce
rm -rf /usr/lib/nagios
rm -rf /var/lib/hdfs
rm -rf /var/lib/hadoop-hdfs
rm -rf /var/lib/hadoop-yarn
rm -rf /var/lib/hadoop-mapreduce
rm -rf /tmp/hadoop-hdfs
rm -rf  /etc/slider
rm -rf  /etc/storm-slider-client
rm -rf /usr/hdp
rm -rf /var/lib/ambari-agent/cache/*
rm -rf /etc/yum.repos.d/ambari*
rm -rf /var/lib/ambari*
rm -rf /var/log/ambari*
rm -rf /etc/ambari*
rm -rf /home/accumulo
rm -rf /home/atlas
rm -rf /home/hcat
rm -rf /home/kafka
rm -rf /home/mapred
rm -rf /home/spark
rm -rf /home/tez
rm -rf /home/ambari-qa
rm -rf /home/falcon
rm -rf /home/hadoop
rm -rf /home/hdfs
rm -rf /home/knox
rm -rf /home/sqoop
rm -rf /home/zookeeper
rm -rf /home/ams
rm -rf /home/flume
rm -rf /home/hbase
rm -rf /home/hive
rm -rf /home/mahout
rm -rf /home/oozie
rm -rf /home/storm
rm -rf /home/yarn
rm -rf /var/lib/ambari-agent/cache
rm -rf /usr/hdp
rm -rf /etc/hive-webhcat
rm -rf /var/run/falcon
rm -rf /var/log/falcon
rm -rf /usr/lib/flume
rm -rf /usr/lib/storm
rm -rf /var/lib/flume
rm -rf /etc/knox
rm -rf /var/lib/knox
rm -rf /var/run/sqoop
rm -rf /var/run/hive-hcatalog
rm -rf /var/run/hadoop-hdfs
rm -rf /var/log/sqoop
rm -rf /var/log/hive-hcatalog
rm -rf /var/log/hadoop-hdfs
rm -rf /var/lib/slider
rm -rf /var/tmp/sqoop
rm -rf /var/run/hadoop
rm -rf /usr/lib/ambari-metrics-collector
python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py

#5.重置数据库，删除ambari包
#采用这句命令来检查yum list installed | grep ambari
ambari-server stop
ambari-agent stop
ambari-server reset
yum remove -y ambari-*
yum remove -y postgresql
yum remove -y mysql*
yum clean all


