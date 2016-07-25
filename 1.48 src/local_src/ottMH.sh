############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottMH.sh,v 0.0 2016年03月22日 星期二 20时12分04秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottMH.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月22日 星期二 20时12分04秒  
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
    channel=a[6];
    act=$3;
    split($16,b,"&");
    playsrc=b[1];
    pt=$28;
    pagename=$17;
    
    if(act=="play"){
      if(pagename!=""){
	aver_pagename[aver"\t"pagename]++;
      }
      if(channel!=""){
	channel_aver[channel"\t"aver]++;
      }

      if(((pt=="0")||(pt=="3"))){
	vv_count[playsrc"\t"aver"\t0"]++;
      }else{
	vv_count[playsrc"\t"aver"\t1"]++;
      }
    }
  } 
}END{
  for(k in aver_pagename){
    print "0", k, aver_pagename[k]; 
  }
  for(k in channel_aver){
    print "1", k, channel_aver[k];
  }
  for(k in vv_count){
    print "2", k, vv_count[k];
  }
}' $input | sort -k1,3 > $out

## vim: set ts=2 sw=2: #

