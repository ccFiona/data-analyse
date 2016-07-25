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

# input1:"intermediate/vv_expOnlyMac_'$stat_date'"
# input2:"intermediate/vv_expOpenOnlyMac_'$stat_date'"
# input3:"intermediate/vv_expBothMac_'$stat_date'"
# input4: logs
# input5: stat_date

# out1:expVVStat {expOnlyVV,expOpenOnlyVV,expBothVV}
# out2:expChannelStat {"cid","totalVV","expVV","openVV","bothVV"}
# out3:expCid {cid,uv}

exp=$1
open=$2
both=$3
input=$4
stat_date=$5

awk 'BEGIN{FS=OFS="\t";}
#ARGIND==1 {exmpLicsList[$1]=$1;}
#ARGIND==2 {openLicsList[$1]=$1;}
#ARGIND==3 {bothLicsList[$1]=$1;}
ARGIND==1 {exmpLicsList[$1"\t"$2]=$1;}
ARGIND==2 {openLicsList[$1"\t"$2]=$1;}
ARGIND==3 {bothLicsList[$1"\t"$2]=$1;}
ARGIND==4 {
aver=$2;
act=$3;
l=$4;
mac=$5;
lics=l"\t"mac;
cid=$10;
pt=$28;
ap=$26;
if((NF>=32)&&(act=="play")&&(pt=="0")||(pt=="3")){
  cidTotal[cid]++;
  if(lics in exmpLicsList){
    cidExp[cid]++;
    expUV[lics]=1;

    cidLicsExp[cid"\t"lics]=1;

#    expUV[aver"\t"lics]=1;
    if(ap==0){
      exmpNAuto[lics]++;
      exmpNAutoVV++;
    }
    else{
      exmpAuto[lics]++;
      exmpAutoVV++;
    }
  }
  if(lics in openLicsList){
    cidOpen[cid]++;
    openUV[lics]=1;
#    openUV[aver"\t"lics]=1;
    if(ap==0){
      openNAuto[lics]++;
      openNAutoVV++;
    }
    else{
      openAuto[lics]++;
      openAutoVV++;
    }
  }
  if(lics in bothLicsList){
    cidBoth[cid]++;
    bothUV[lics]=1;
#    bothUV[aver"\t"lics]=1;
#    if((aver=="5.0.1.999.2.TY.0.0_Release")||(aver=="5.1.103.999.2.TY.0.0_Release")){
    if(aver=="5.1.104.999.2.TY.0.0_Release"){
      if(ap==0){
       # bothNAuto[lics]++;
        bothNAutoVV++;
      }
      else{
       # bothAuto[lics]++;
        bothAutoVV++;
      }
    }else{
      if(ap==0){
       # bothNAuto[lics]++;
        bothOpNAutoVV++;
      }
      else{
       # bothAuto[lics]++;
        bothOpAutoVV++;
      }
    }
  }
}
}
END{
#print "stat_date","expUV","eNAVV","eAVV","openUV","oNAVV","oAVV","bothUV","bEpNAVV","bEpAVV","bOpNAVV","bOpAVV" >> "expVVStat";
print "'$stat_date'",length(exmpLicsList),exmpNAutoVV,exmpAutoVV,length(openLicsList),openNAutoVV,openAutoVV,length(bothLicsList),bothNAutoVV,bothAutoVV,bothOpNAutoVV,bothOpAutoVV >> "expVVStat";

print "cid","totalVV","expVV","openVV","bothVV" >> "intermediate/experimental/channelVV_'$stat_date'";
for(c in cidTotal){
  printf("%-20s\t%d\t%d\t%d\t%d\n", c,cidTotal[c],cidExp[c],cidOpen[c],cidBoth[c]);
}

for(l in cidLicsExp){
  split(l,a,"\t");
  cidExpUV[a[1]]++;
}
for(u in cidExpUV){
  print u,cidExpUV[u] > "intermediate/experimental/channelExpUV_'$stat_date'";
}

}
' $exp $open $both $input | sort -k2rn,2 >> intermediate/experimental/channelVV_$stat_date 

## vim: set ts=2 sw=2: #

