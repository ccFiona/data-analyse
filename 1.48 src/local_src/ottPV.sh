############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottPV.sh,v 0.0 2016年03月16日 星期三 18时54分17秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottPV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 18时54分17秒  
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
    split($2,a,".");
    aver=a[1]"."a[2];
    uuid=$21;
    playsrc=$14;
    act=$3;
    pagename=$11;

    if(act=="pageload"&&pagename=="C"){
      pv_count[aver"\t"playsrc]++;
      uniq_pv[aver"\t"playsrc"\t"uuid]=1;
    }

  }
}END{
  for(key in uniq_pv){
    split(key,b,"\t");
    v_key=b[1]"\t"b[2];
    uniq_pv_count[v_key]++;
  }
  for(key in pv_count){
    if(key in uniq_pv_count){
      print key, pv_count[key], uniq_pv_count[key];
    }else{
      print key, pv_count[key], 0;
    }
  }
}' $input | sort -k1,1 > $out

## vim: set ts=2 sw=2: #

