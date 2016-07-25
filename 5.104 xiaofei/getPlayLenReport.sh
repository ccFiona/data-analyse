############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmMacList.sh,v 0.0 2016年05月25日 星期三 14时26分34秒  <tangye> Exp $ 
## 
############################################################################
#
###
#!/bin/bash

####
# input: statistic interval
# (statistic from yesterday to yesterday-interval)
#
# ori_log:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
#
# output: lics_num(5.0|5.1)

interval=$1
set=$2

echo `date +%Y%m%d --date="-$interval day"`
echo `date +%Y%m%d --date="-$set day"`

inputlogs=/data/dev/tangye/ott/logs/data
intermediate=/data/dev/xiaofei/intermediate

cd /data/dev/xiaofei

#####
# get vedio len data from mysql, put in: inputlogs/vid_span
sh getVedioLenData.sh

for((j=$interval;j>=$set;j--))
do
  tem=`date +%Y%m%d --date="-$j day"`

#  i=$[$j+1]
#  tem_yest=`date +%Y%m%d --date="-$i day"`
  sh getPlayStopLogs.sh $inputlogs/$tem/vv_$tem $intermediate/playStopLogs_$tem

  sh getPlayLen.sh /data/dev/xiaofei/inputlogs/vid_span /data/dev/xiaofei/inputlogs/active_tmp_$tem $intermediate/playStopLogs_$tem $tem
  cp playLenReport/playLenReport.csv /data/dev/tangye/ott/daily_report/playLenReport.csv
done

## vim: set ts=2 sw=2: #

