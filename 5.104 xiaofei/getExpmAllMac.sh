############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmOpenStat.sh,v 0.0 2016年05月26日 星期四 10时50分10秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getExpmAllMac.sh 
# # @date   2016年05月26日 星期四 10时50分10秒  
# # @brief 
# #  
# ##
#!/bin/bash

####
# input1:all_mac_yesterday
# input2:active_logs_today active_tmp_today
# input3:stat_date

# out:"intermediate/experimental/'ll_mac_$stat_date'"

all_mac=$1
input=$2
stat_date=$3

echo $stat_date
awk 'BEGIN{FS=OFS="\t";}
ARGIND==1{exmpLicsList[$1"\t"$2"\t"$3]=1;}
ARGIND==2{
aver=$2;
lics=$4;
mac=$5;
#  print aver,lics > "tempfile";
#if((aver=="5.0.1.999.2.TY.0.0_Release")||(aver=="5.1.103.999.2.TY.0.0_Release")){
if(aver=="5.1.104.999.2.TY.0.0_Release"){
  exmpLicsList[aver"\t"lics"\t"mac]=1;
}
}END{
for(e in exmpLicsList){
    print e > "intermediate/experimental/all_mac_'$stat_date'";
}
}
' $all_mac $input

## vim: set ts=2 sw=2: #

