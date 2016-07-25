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
reset=$2
global_path=/data/dev/xiaofei
inputlogs_path=$global_path/inputlogs
inter_path=$global_path/intermediate

echo `date +%Y%m%d --date="-$interval day"`
echo `date +%Y%m%d --date="-$reset day"`

  tem=`date +%Y%m%d --date="-$interval day"`
  i=$[$interval-1]
  tem_tm=`date +%Y%m%d --date="-$i day"`
  sh getConsistUser.sh $inter_path/vv_expOnlyMac_$tem $inter_path/vv_expOnlyMac_$tem_tm $tem_tm

for((j=$[$interval-2];j>=$reset;j--))
do
  i=$[$j+1]
  tem=`date +%Y%m%d --date="-$i day"`
  date=`date +%Y%m%d --date="-$j day"`
  sh getConsistUser.sh $inter_path/expConsistUsers_$tem $inter_path/vv_expOnlyMac_$date $date
done

## vim: set ts=2 sw=2: #

