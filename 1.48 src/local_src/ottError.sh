############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottError.sh,v 0.0 2016年03月16日 星期三 17时33分00秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottError.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 17时33分00秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2

#########
# input:ip, aver, act, lics, mac, time, sver, net, mf, mod, errorCode, errorMess, 
# serverCode, pt, tpt, vid, ovid,  plid, oplid, lcid, sourceid, streamid, ln, liveid, pt, uuid,
# isdebug
#
# returns: aver, mf, errorCode, count

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=25){
    aver=$2;
    mf=$9;
    errorCode=$11;

    count[aver"\t"mf"\t"errorCode]++;
  }
}END{
  for(key in count){
    print key, count[key];
  }
}'

## vim: set ts=2 sw=2: #

