#!/bin/bash

interval="14"

yesterday=`date +%Y%m%d --date="-1 day"`

# report from 2 weeks before
report_begindate=`date +%Y%m%d --date="-$interval day"`
echo $yesterday
echo $report_begindate

global_path=/data/dev/xiaofei

# report save path
syn_path=$global_path/report


# input logs path
logs_path=/data/dev/tangye/ott/logs/data
inputlogs_path=$global_path/inputlogs
# out logs path
statlog_path=$global_path/middlelogs


#####
#mkdir $syn_path
#mkdir $statlog_path
#mkdir $global_path/inputlogs

#rm $statlog_path/vv/*

#####

#####
# get mac list
# vv_maclist
# get vv logs
for((j=1;j<=$interval;j++))
do
  tem=`date +%Y%m%d --date="-$j day"`
  mkdir $inputlogs_path/$tem
  mkdir $statlog_path/$tem
  mkdir $syn_path/$tem

  cp $logs_path/$tem/vv_$tem $inputlogs_path/$tem
  sh getMac.sh $inputlogs_path/$tem/vv_$tem $statlog_path/$tem/vv_mac_$tem $statlog_path/$tem/vvplay_logs_$tem
  sh getVVMac.sh $statlog_path/$tem/vv_mac_$tem $statlog_path/$tem/vvplay_logs_$tem $syn_path/$tem/vv_mac_$tem
  sh getVV.sh $syn_path/$tem/vv_mac_$tem $syn_path/vv_stat $tem
done


######
# get experimental VV result

#####
