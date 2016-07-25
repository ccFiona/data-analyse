############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmOpenStat.sh,v 0.0 2016年05月26日 星期四 10时50分10秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getExpmOpenStat.sh 
# # @date   2016年05月26日 星期四 10时50分10秒  
# # @brief 
# #  
# ##
#!/bin/bash

####
# input1: "intermediate/expLics_'$stat_date'"

# out1:"intermediate/expLicsAll"

logs=$1
licsAll=$2
stat_date=$3

cd /data/dev/xiaofei

awk 'BEGIN{FS=OFS="\t";}
{
UV[$1]=1;
}
END{
for(u in UV){
  print u > "intermediate/expLicsAll_tmp";
}
}
' $logs $licsAll

## vim: set ts=2 sw=2: #

