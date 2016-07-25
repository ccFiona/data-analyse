############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmTopSet.sh,v 0.0 2016年06月21日 星期二 18时02分31秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getExpmTopSet.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年06月21日 星期二 18时02分31秒  
# # @brief 
# #  
# ##
#!/bin/bash

##############
# input1: report/vid_info
# input2: report/'$stat_date'/his_top_set_'date'{setName,cidName,vv,uv}
# input3: date

#vid=$1
topSet=$1
date=$2

awk 'BEGIN{FS=OFS=",";}
{
  print $0;
}
' $topSet | sort -t $',' -k3nr | head -n 100 > report/$date/his_top_$date.csv
## vim: set ts=2 sw=2: #

