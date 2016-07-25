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

cd $global_path
#sh getVedioSetInfo.sh

for((j=$interval;j>=$set;j--))
do
  tem=`date +%Y%m%d --date="-$j day"`

  if [ ! -f "inputlogs/active_tmp_$tem" ]; then
  cat $inputlogs_path/$tem/pv_$tem $inputlogs_path/$tem/start_$tem $inputlogs_path/$tem/error_$tem $inputlogs_path/$tem/vv_$tem > inputlogs/active_tmp_$tem
  fi

  if [ ! -d "report/$tem" ]; then
  mkdir report/$tem
  fi
  sh getExpmLicsHistoryStat.sh $inter_path/expLicsAll inputlogs/active_tmp_$tem report/vid_info report/code_dict $inputlogs_path/$tem/vv_$tem $tem
  sh getExpmHisTopSet.sh report/$tem/his_top_set_$tem $tem
  
  #####
  # characterset change
  iconv -f utf-8 -t gbk report/$tem/his_top_$tem.csv > report/$tem/h_top_$tem.csv
  iconv -f utf-8 -t gbk report/$tem/his_cidvv_uv_$tem.csv > report/$tem/h_cid_$tem.csv

  rm report/$tem/his_top_$tem.csv report/$tem/his_cidvv_uv_$tem.csv report/$tem/his_top_set_$tem

done

## vim: set ts=2 sw=2: #

