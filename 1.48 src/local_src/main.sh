############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: main.sh,v 0.0 2016年03月17日 星期四 19时31分50秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   main.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 19时31分50秒  
# # @brief 
# #  
# ##
#!/bin/bash


today=$1

sh run.sh $today

cd ./transform

sh run.sh $today

###
# compress logs 2 month ago
#compressDay=`date -d "2 month ago $today" +%Y%m%d`
#log_path=/data/dev/tangye/ott/logs/data
#backup_path=/data/dev/tangye/ott/logs_bak
#cd $log_path
#tar -cjf $backup_path/$compressDay.tar.bz2 $compressDay/
#
#rm -rf $compressDay
## vim: set ts=2 sw=2: #

