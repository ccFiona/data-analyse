############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getMacList_exp.sh,v 0.0 2016年05月25日 星期三 14时48分19秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getMacList_exp.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月25日 星期三 14时48分19秒  
# # @brief 
# #  
# ##
#!/bin/bash

#####
# inputs1:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug
# inputs2: stat_date

# out1: maclist(exp|old|new)
# "intermediate/vv_expmMac_'$stat_date'"
# out2: expmStatReport

input=$1
stat_date=$2

echo $stat_date

awk '
BEGIN{FS=OFS="\t";}
{
  aver=$2;
  act=$3;
  pt=$28;

#  if((NF>=32)&&(act=="play")&&(pt=="0")||(pt=="3")){
  if((act=="play")&&(pt=="0")||(pt=="3")){
  if(aver=="5.0.1.999.2.TY.0.0_Release"){
    oldEdLics[$4]++;
  }
  if(aver=="5.1.103.999.2.TY.0.0_Release"){
    newEdLics[$4]++;
  }
  if((aver=="5.0.1.999.2.TY.0.0_Release")||(aver=="5.1.103.999.2.TY.0.0_Release")){
    expEdLics[$4]++;
  }
}
}END{
expVV=0;
newVV=0;
oldVV=0;
for(e in expEdLics){
  expVV+=expEdLics[e];
}
for(n in newEdLics){
  newVV+=newEdLics[n];
  print "5.1.103.999.2.TY.0.0_Release",n,newEdLics[n] > "intermediate/vv_expmMac_'$stat_date'";
}
for(o in oldEdLics){
  oldVV+=oldEdLics[o];
  print "5.0.1.999.2.TY.0.0_Release",o,oldEdLics[o] > "intermediate/vv_expmMac_'$stat_date'";
}
print "stat_date","exp_UV","new_UV","old_UV","exp_VV","new_VV","old_VV";
print "'$stat_date'",length(expEdLics),length(newEdLics),length(oldEdLics),expVV,newVV,oldVV;
}
' $input >> expmStatReport
## vim: set ts=2 sw=2: #
