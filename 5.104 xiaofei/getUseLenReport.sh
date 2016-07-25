############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmMacList.sh,v 0.0 2016年05月25日 星期三 14时26分34秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getExpmStatMain.sh 
# # @date   2016年05月25日 星期三 14时26分34秒  
# # @brief 
# #  
# ##
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
global_path=/data/dev/xiaofei
#inputlogs_path=$global_path/inputlogs
inputlogs_path=/data/dev/tangye/ott/logs/data
inter_path=$global_path/intermediate

echo `date +%Y%m%d --date="-$interval day"`
echo `date +%Y%m%d --date="-$set day"`

for((j=$interval;j>=$set;j--))
do
  tem=`date +%Y%m%d --date="-$j day"`
  sh getPV_VV_time.sh $inputlogs_path/$tem/pv_$tem $inputlogs_path/$tem/vv_$tem $tem
  sh getUseLen.sh $inputlogs_path/$tem/start_$tem useLenReport/pv_vv_tmp_$tem $tem
done

## vim: set ts=2 sw=2: #

