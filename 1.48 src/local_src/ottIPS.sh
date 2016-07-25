############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottIPS.sh,v 0.0 2016年05月16日 星期一 15时58分14秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottIPS.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月16日 星期一 15时58分14秒  
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
    lics=$4;
    plid=$27;
    
    if(pt==""){pt="null"}

    if(((pt=="0")||(pt=="3"))&&(playsrc!="")&&(act=="play")){
      vv_count[lics"\t"plid]++;
    }
  } 
}END{
  for(key in vv_count){
    split(key,b,"\t")
    lics_count[b[1]]++
  }
  
  for(lics in lics_count){
    ip_num+=lics_count[lics]
    count_dis[lics_count[lics]]++
  }
  user_num=length(lics_count)
  print 0, ip_num/user_num
  for(c in count_dis){
    print c, count_dis[c]
  }
}' $input | sort -k1n,1 > $out

## vim: set ts=2 sw=2: #


