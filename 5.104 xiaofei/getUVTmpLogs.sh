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
#  sh getExpmDailyStat.sh $inputlogs_path/$tem/vv_$tem $tem
#  sh getExpmOpenStat.sh $inter_path/vv_expmMac_$tem $inputlogs_path/$tem/vv_$tem $tem

  cat $inputlogs_path/$tem/pv_$tem $inputlogs_path/$tem/start_$tem $inputlogs_path/$tem/error_$tem > inputlogs/active_tmp_$tem
#  i=$[$j+1]
#  tem_yest=`date +%Y%m%d --date="-$i day"`
#  sh getExpmAllMac.sh $inter_path/experimental/all_mac_$tem_yest $inputlogs_path/active_tmp_$tem $tem

#  sh getActiveUser.sh $inputlogs_path/active_tmp_$tem $tem

#  sh getExpmMacLicsStat.sh $inputlogs_path/active_tmp_$tem $inputlogs_path/$tem/vv_$tem $tem

#  sh getExpmOpenStat2.sh $inter_path/experimental/all_mac_$tem $inter_path/active_lics_$tem $tem

#  sh getExpmOpenStatReport.sh $inter_path/vv_expOnlyMac_$tem $inter_path/vv_expOpenOnlyMac_$tem $inter_path/vv_expBothMac_$tem $inputlogs_path/$tem/vv_$tem $tem
done

## vim: set ts=2 sw=2: #

