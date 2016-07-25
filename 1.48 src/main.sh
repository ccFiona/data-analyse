#bin/bash

#export JAVA_HOME=/usr/local/java/jdk1.7.0_67

#rm /home/ottadmin/dev/tangye/ott/log
today=`date +%Y%m%d`
yesterday=`date -d "1 day ago $today" +%Y%m%d`
two_month_ago=`date -d "2 month ago $today" +%Y%m%d`
echo $yesterday

cd /home/ottadmin/dev/tangye/stats_log/data
rm -rf $yesterday
mkdir $yesterday


cd /home/ottadmin/dev/tangye/stats_log/src

sh getCleanVV.sh $yesterday $yesterday
sh getCleanPV.sh $yesterday $yesterday
sh getCleanQplay.sh $yesterday $yesterday
sh getCleanError.sh $yesterday $yesterday
sh getCleanStart.sh $yesterday $yesterday
sh getCleanAd.sh $yesterday $yesterday

sh download_data.sh $yesterday $today

cd /home/ottadmin/dev/tangye/stats_log/data
scp -r $yesterday root@10.100.5.104:/data/dev/tangye/ott/logs/data

rm -rf $yesterday
