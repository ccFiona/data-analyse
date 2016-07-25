############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottUVDAU.sh,v 0.0 2016年03月22日 星期二 10时21分23秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottUVDAU.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月22日 星期二 10时21分23秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2
type=$3

######
# inputs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
# isdebug
# 
# Returns: aver, mac

awk 'BEGIN{FS=OFS="\t";
  idx=5;
  if(!("'$type'"=="mac")){
    idx=4;
  }
}{
  if(NF>=32){
    aver=$2;
    act=$3;
    mac=$idx;

    if(act=="play"){
      user[aver"\t"mac]=1;
    }
  }
}END{
  for(u in user){
    print u;
  }
}' $input | sort -k1,1 > $out


## vim: set ts=2 sw=2: #

