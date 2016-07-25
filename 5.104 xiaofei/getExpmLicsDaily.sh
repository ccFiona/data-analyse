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
# input1: all_logs
# input4: vv_log{ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,...
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug}
# input5: stat_date

# out1:"expmMacLicsUV_'$stat_date'"
# out2:

logs=$1
input=$2
stat_date=$3

cd /data/dev/xiaofei

awk 'BEGIN{FS=OFS="\t";}
ARGIND==1 {
aver=$2;
lics=$4;
mac=$5;
if(aver=="0.1.108.999.2.TY.0.0_Release")
  UV[lics]=1;
}
ARGIND==2 {
aver=$2;
lics=$4;
mac=$5;
if(aver=="0.1.108.999.2.TY.0.0_Release"){
    UV[lics]=1;
}
}
END{

for(u in UV){
  print u > "intermediate/expLics_'$stat_date'";
}
}
' $logs $input 

## vim: set ts=2 sw=2: #

