############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottQplay.sh,v 0.0 2016年03月16日 星期三 16时57分07秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottQplay.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 16时57分07秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2

#######
# input:ip, aver, act, lics, mac, time, sver, net,  suuid, pt, idx, mf, mod,
# pagename, lcid, sourceid, streamid, ln, liveid, td, vid, ovid, plid, oplid,
# uuid, isdebug
#
# returns: act, live_count, nonLive_count

awk 'BEGIN{FS=OFS="\t"}{
 if(NF>=26){
   split($2,a,".");
   aver=a[1]"."a[2];
   act=$3;
   pt=$28;

   if(pt==""){pt="null"}

   if((pt=="0")||(pt=="3")){
      live_count[aver"\t"act]++;
   }else{
      nonLive_count[aver"\t"act]++;
   }
 } 
}END{
  for(key in live_count){
    if(key in nonLive_count){
      print key, live_count[key], nonLive_count[key];
    }else{
      print key, live_count[key], 0;
    }
  }
}'

## vim: set ts=2 sw=2: #

