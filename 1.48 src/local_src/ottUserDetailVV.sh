############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottUserVV.sh,v 0.0 2016年03月16日 星期三 20时03分49秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottUserVV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 20时03分49秒  
# # @brief 
# #  
# ##
#!/bin/bash

code_dict=$1
vid_info=$2
input=$3
out=$4

######
# inputs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
# isdebug
# 
# Returns:  act=play, cid, mac, vid, vv 

awk 'BEGIN{FS=OFS="\t"}
ARGIND==1{
  code_dict[$1]=$2;  
}
ARGIND==2{
  if($3 in code_dict){
    vid_info[$1]=code_dict[$3];
  }
}
ARGIND==3{
  if(NF>=32){
    act=$3;
    cid=$10;
    mac=$5;
    vid=$11;
    if(vid in vid_info){
      cid=vid_info[vid]
    }
    pt=$28;
    
    if(pt==""){pt="null"}

    if((act=="play")&&(cid!="")){
      if((pt=="0")||(pt=="3")){
        vv_count[cid"\t"mac"\t"vid]++;
      }
    }
  } 
}
END{
  for(key in vv_count){
    print key, vv_count[key];
  }
}' $code_dict $vid_info $input | sort -k1,3 > $out

## vim: set ts=2 sw=2: #

