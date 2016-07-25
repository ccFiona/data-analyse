############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmOpenStat.sh,v 0.0 2016年05月26日 星期四 10时50分10秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @date   2016年05月26日 星期四 10时50分10秒  
# # @brief 
# #  
# ##
#!/bin/bash

####
# input:all_logs active_tmp_$stat_date
# input2:stat_date

# output:active_lics_$stat_date
# aver,lics


all_logs=$1
stat_date=$2

awk 'BEGIN{FS=OFS="\t";}
{
aver=$2;
lics=$4;
mac=$5;
if(NF>=5)
  activeUserList[aver"\t"lics"\t"mac]=1;
}END{
for(l in activeUserList)
  print l > "intermediate/active_lics_'$stat_date'";
}
' $all_logs

## vim: set ts=2 sw=2: #

