############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: list_cid_pv.sh,v 0.0 2016年05月11日 星期三 09时44分15秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   list_cid_pv.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月11日 星期三 09时44分15秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2

###########
# input: ip, aver, act, lics, mac, time, sver, net, mf, mod,
# pagename, ext1 ~ ext10
# isdebug
#
# returns: aver, ext3, pv, uniq_pv(uniq by ext10, pagename=C, act=pageload)

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=22){
    act=$3;
    pagename=$11;
    cid=$15;

    if(act=="pageload"&&pagename~/B/){
      pv_count[pagename"\t"cid]++;
    }

  }
}END{
  for(key in pv_count){
    print key, pv_count[key]
  }
}' $input | sort -k1,2 > $out

## vim: set ts=2 sw=2: #


