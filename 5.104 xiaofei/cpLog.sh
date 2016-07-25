#!/bin/bash

interval=$1

yesterday=`date +%Y%m%d --date="-1 day"`

report_begindate=`date +%Y%m%d --date="-$interval day"`
echo $yesterday
echo $report_begindate

global_path=/data/dev/xiaofei

# input logs path
logs_path=/data/dev/tangye/ott/logs/data
# out logs path
inputlogs_path=$global_path/inputlogs


#####
# get vv logs
for((j=1;j<=$interval;j++))
do
  tem=`date +%Y%m%d --date="-$j day"`
  mkdir $inputlogs_path/$tem
#  mkdir $statlog_path/$tem

  cp $logs_path/$tem/* $inputlogs_path/$tem
done

