############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmOpenStat.sh,v 0.0 2016年05月26日 星期四 10时50分10秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getExpmOpenStat.sh 
# # @date   2016年05月26日 星期四 10时50分10秒  
# # @brief 
# #  
# ##
#!/bin/bash

####
# input1:exmp_maclist{aver(5.0|5.1),mac}
# "intermediate/vv_expmMac_'$stat_date'"

# input2:orig_logs{ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,...
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug}
# input3:stat_date

# out1:"intermediate/vv_expmExtMac_'$stat_date'"
# out2:expOpenStat

exmpLics=$1
input=$2
stat_date=$3

awk 'BEGIN{FS=OFS="\t";}
ARGIND==1 {exmpLicsList[$2]=$2;}
ARGIND==2 {
aver=$2;
act=$3;
lics=$4;
pt=$28;
ap=$26;
if((NF>=32)&&(act=="play")&&(pt=="0")||(pt=="3")){
  if(!(lics in exmpLicsList)){
    openVV[lics]++;
    openTotalVV++;
  }
  else if(lics in exmpLicsList){
    if((aver!="5.0.1.999.2.TY.0.0_Release")&&(aver!="5.1.103.999.2.TY.0.0_Release")){
      exmpExcpLics[lics]++;
    }
    else if((aver=="5.0.1.999.2.TY.0.0_Release")||(aver=="5.1.103.999.2.TY.0.0_Release")){
      exmpLicsVV[lics]++;
      if(ap=="0"){
        nonAuto[lics]++;
      }
    else
      auto[lics]++;
    }
  }
}
}
END{
for(l in exmpLicsList){
  exmpExcpUV=0;
  exmpExcpVV=0;
  nonAtVV=0;
  atVV=0;
  if(!(l in exmpExcpLics)){
    exmpExcpUV++;
    exmpExcpVV+=exmpLicsVV[l];
    if(l in nonAuto)
      nonAtVV+=nonAuto[l];
    else if(l in auto)
      atVV+=auto[l];
    print l > "intermediate/vv_expmExtMac_'$stat_date'"
  }
}
print "stat_date","openVV","openUV","exmpVV","exmpUV","autoVV","nonAtVV";
print "'$stat_date'",openTotalVV,length(openVV),exmpExcpVV,exmpExcpUV,atVV,nonAtVV;
}
' $exmpLics $input >> expmOpenStatReport

## vim: set ts=2 sw=2: #

