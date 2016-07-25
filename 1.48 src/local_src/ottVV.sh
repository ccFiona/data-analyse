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
# Returns: aver, act, playsrc, vv(pt=0|3), nonauto_vv(ap=0)

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=32){
    split($2,a,".");
    aver=a[1]"."a[2];
    act=$3;
    split($16,b,"&");
    playsrc=b[1];
    pt=$28;
    ap=$26;
    
    if(pt==""){pt="null"}
    if(ap==""){ap="0"}

    if(((pt=="0")||(pt=="3"))&&(playsrc!="")){
      vv_count[aver"\t"act"\t"playsrc]++;
      if(ap=="0"){
        nonauto_vv_count[aver"\t"act"\t"playsrc]++;
      }
    }
  } 
}END{
  for(key in vv_count){
    if(key in nonauto_vv_count){
      print key, vv_count[key], nonauto_vv_count[key];
    }
    else{
      print key, vv_count[key], 0;
    }
  }
}' $input | sort -k1,3 > $out

## vim: set ts=2 sw=2: #

