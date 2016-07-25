############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottVVHour.sh,v 0.0 2016年03月17日 星期四 09时48分25秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottVVHour.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 09时48分25秒  
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
# Returns: aver>=4.10, total_hours(minutes), vv, avg_hours

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=32){
    split($2,a,".");
    if((a[2]-10)>=0){
      act=$3;
      pt=$28;
      
      if(pt==""){pt="null"}

      if((pt=="0")||(pt=="3")){
        if(act=="play"){
          vv++;
        }
        if(act=="stop"){
          td=$14;
          if(td==""||td=="null"){td=0}
          hours+=td
        }
      }
    }
  }
}END{
  print hours, vv, hours/vv/3600
}' $input | sort -k1,3 > $out

## vim: set ts=2 sw=2: #

