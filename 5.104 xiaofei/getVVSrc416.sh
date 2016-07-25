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
# input1: orig_logs{ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,...
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug}
# input2: vv_keys 
# input3: stat_date

# out1:"report/vv_src_'$stat_date'"

input=$1
keys=$2
stat_date=$3

cd /data/dev/xiaofei

awk 'BEGIN{FS="\t";OFS=","}
ARGIND==1 {
aver=$2;
act=$3;
lics=$4;
mac=$5;
pt=$28;
#if(aver=="0.1.108.999.2.TY.0.0_Release"){
if(aver~/^4.16/){
    UV[lics]=1;
    if((NF>=32)&&(act=="play")&&(pt=="0")||(pt=="3")){
      split($16,a,"&");
      vvSrc[a[1]]++;
    }
  }
}
ARGIND==2 {
print $1,$2,vvSrc[$1] > "report/'$stat_date'/vv_src_416_'$stat_date'.csv";
}
#END{
#for(s in vvSrc)
#  print s,vvSrc[s] > "report/'$stat_date'/vv_srcTotal_'$stat_date'.csv"
#}
' $input $keys 

## vim: set ts=2 sw=2: #

