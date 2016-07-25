############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: batch_get.sh,v 0.0 Thu 29 Oct 2015 04:29:04 PM CST  dongjie Exp $ 
## 
############################################################################
#
###
# # @file   batch_get.sh 
# # @author dongjie<dongjie@e.hunantv.com>
# # @date   Thu 29 Oct 2015 04:29:04 PM CST  
# # @brief 
# #  
# ##
#!/bin/bash

## vim: set ts=2 sw=2: #

cd /home/ottadmin/dev/tangye/stats_log/data

begin_date=$1
end_date=$2


if [ $begin_date -gt $end_date ]; then
  echo "begin_date > end_date";
  exit -1;
fi

begindate=`date -d "$1" +%Y%m%d`
enddate=`date -d "$2" +%Y%m%d`

while [ $begindate -lt $enddate ]
do
  echo $begindate
  hadoop fs -getmerge /data/ott/tangye/clean_vv/$begindate"_"$begindate $begindate/vv_$begindate
  hadoop fs -getmerge /data/ott/tangye/clean_pv/$begindate"_"$begindate $begindate/pv_$begindate
  hadoop fs -getmerge /data/ott/tangye/clean_qplay/$begindate"_"$begindate $begindate/qplay_$begindate
  hadoop fs -getmerge /data/ott/tangye/clean_start/$begindate"_"$begindate $begindate/start_$begindate
  hadoop fs -getmerge /data/ott/tangye/clean_error/$begindate"_"$begindate $begindate/error_$begindate
  hadoop fs -getmerge /data/ott/tangye/clean_ad/$begindate"_"$begindate $begindate/ad_$begindate
  begindate=`date -d "1 days $begindate" +%Y%m%d`
done
