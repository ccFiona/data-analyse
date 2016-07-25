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
# input1:all_mac_$stat_date
# input2:active_lics_$stat_date
# aver,lics
# input3:stat_date

# out1:"intermediate/vv_expOnlyMac_'$stat_date'"
# out2:"intermediate/vv_expOpenOnlyMac_'$stat_date'"
# out3:"intermediate/vv_expBothMac_'$stat_date'"

all_mac=$1
activeLics=$2
stat_date=$3

awk 'BEGIN{FS=OFS="\t";}
ARGIND==1{exmpLicsList[$2"\t"$3]=1;}
ARGIND==2{
aver=$1;
lics=$2;
mac=$3;
if(lics"\t"mac in exmpLicsList){
  licsList[lics"\t"mac]++;
 # print lics,aver > "tempfile";
#  if((aver=="5.0.1.999.2.TY.0.0_Release")||(aver=="5.1.103.999.2.TY.0.0_Release")){
  if(aver=="5.1.104.999.2.TY.0.0_Release"){
    expList[lics"\t"mac]++;
  }
else{
     openList[lics"\t"mac]++;}
   }
 }END{
for(l in licsList){
  if((l in expList)&&(l in openList)){
    print l > "intermediate/vv_expBothMac_'$stat_date'";
  }

  if((l in expList)&&(!(l in openList))){
    print l > "intermediate/vv_expOnlyMac_'$stat_date'";
  }
  
  if((!(l in expList))&&(l in openList)){
    print l > "intermediate/vv_expOpenOnlyMac_'$stat_date'";
  }
}
}
' $all_mac $activeLics

## vim: set ts=2 sw=2: #

