############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottVV.sh,v 0.0 2016年03月16日 星期三 15时17分17秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottVV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 15时17分17秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2

######
# inputs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
# isdebug
# 
# Returns: aver, suuid, act, vv_count(pt=0|3)

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=26){
    split($2,a,".");
    aver=a[1]"."a[2];
    act=$3;
    suuid=$9;
    pt=$28;
    if(act=="gflow"||act=="qplay"){
      pt=$10
    }
    
    if(pt==""){pt="null"}

    if((pt=="0")||(pt=="3")){
      vv_count[aver"\t"suuid"\t"act]++;
    }
  } 
}END{
  for(key in vv_count){
    print key, vv_count[key];
  }
}' $input | sort -k1,3 > $out

## vim: set ts=2 sw=2: #

