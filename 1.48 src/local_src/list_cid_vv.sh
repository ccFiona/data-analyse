############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: list_cid_vv.sh,v 0.0 2016年05月11日 星期三 09时49分05秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   list_cid_vv.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月11日 星期三 09时49分05秒  
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
    act=$3;
    split($16,b,"&");
    playsrc=b[1];
    pt=$28;
    ap=$26;
    cid=$10;
    
    if(pt==""){pt="null"}
    if(ap==""){ap="0"}

    if(act=="play"){
      if(((pt=="0")||(pt=="3"))&&(playsrc~/B/)){
	vv_count[playsrc"\t"cid]++;
      }
    }
  } 
}END{
  for(key in vv_count){
    print key, vv_count[key]
  }
}' $input | sort -k1,2 > $out

## vim: set ts=2 sw=2: #

