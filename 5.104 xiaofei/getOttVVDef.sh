############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getMac.sh,v 0.0 2016年06月23日 星期四 11时38分27秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @brief 
# #  
# ##
#!/bin/bash

#######
# input:ottVV_date{ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref,#  ap,plid, pt, uuid, cf, istry,isdebug}
# return:

input=$1
date=$2

awk '
BEGIN{FS="\t";OFS=",";
}
{
  defString=tolower($20);
  pt=$28;
  if((NF>=32)&&($3=="play")&&((pt=="0")||(pt=="3"))){
    def[defString]++;
    vv++;
  }
}
END{
for(d in def){
  print d,def[d],vv,def[d]/vv;
}
}
' $input | sort -t $',' -k4g > ottDef_$date.cvs

## vim: set ts=2 sw=2: #

