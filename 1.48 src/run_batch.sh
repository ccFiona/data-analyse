############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: run_each_day.sh,v 0.0 Mon 26 Oct 2015 02:34:17 PM CST  dongjie Exp $ 
## 
############################################################################
#
###
# # @file   run_each_day.sh 
# # @author dongjie<dongjie@e.hunantv.com>
# # @date   Mon 26 Oct 2015 02:34:17 PM CST  
# # @brief 
# #  
# ##
#!/bin/bash

## vim: set ts=2 sw=2: #


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
  #sh simpleVV.sh $begindate $begindate
  #sh simpleFeedback.sh $begindate $begindate
  #sh simpleSearch.sh $begindate $begindate
  #sh getCleanVV.sh $begindate $begindate
  #sh getCleanPV.sh $begindate $begindate
  #sh getCleanQplay.sh $begindate $begindate
  #sh getCleanError.sh $begindate $begindate
  #sh getCleanStart.sh $begindate $begindate
  #sh getCleanAd.sh $begindate $begindate
  sh main_manual.sh $begindate
  begindate=`date -d "1 days $begindate" +%Y%m%d`
done


