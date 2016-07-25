############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: compress_log.sh,v 0.0 2016年05月24日 星期二 09时54分45秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   compress_log.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月24日 星期二 09时54分45秒  
# # @brief 
# #  
# ##
#!/bin/bash

today=$1
compressDay=`date -d "2 month ago $today" +%Y%m%d`
log_path=/data/dev/tangye/ott/logs/data
backup_path=/data/dev/tangye/ott/logs_bak
cd $log_path
tar -cjf $backup_path/$compressDay.tar.bz2 $compressDay/

#cd $log_path/$compressDay
#rm -rf "*_"$compressDay
rm -rf $compressDay

## vim: set ts=2 sw=2: #

