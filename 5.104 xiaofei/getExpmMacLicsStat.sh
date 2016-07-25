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
# input1: all_logs
# input2: report/vid_info {setid,setname,vid}
# input3: report/code_dict {cid,cidname}
# input4: orig_logs{ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,...
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug}
# input5: stat_date

# out1:"expmMacLicsUV_'$stat_date'"
# out2:

logs=$1
vid_info=$2
code_dict=$3
input=$4
stat_date=$5

cd /data/dev/xiaofei

awk 'BEGIN{FS="\t";OFS=","}
ARGIND==1 {
aver=$2;
lics=$4;
mac=$5;
#if((aver=="5.0.1.999.2.TY.0.0_Release")||(aver=="5.1.103.999.2.TY.0.0_Release"))
if(aver=="0.1.108.999.2.TY.0.0_Release")
#  exmpMacLicsList[$4"\t"$5]=1;
  UV[lics]=1;
}
ARGIND==2 {
setName[$1]=$2;
cidList[$1]=$3;
}
ARGIND==3 {
cidName[$1]=$2;
}
ARGIND==4 {
aver=$2;
act=$3;
lics=$4;
mac=$5;
#cid=$10;
setid=$11;
cid=cidList[setid];
pt=$28;
ap=$26;
if(aver=="0.1.108.999.2.TY.0.0_Release"){
    UV[lics]=1;
#    if((aver=="5.0.1.999.2.TY.0.0_Release")||(aver=="5.1.103.999.2.TY.0.0_Release")){
    if((NF>=32)&&(act=="play")&&(pt=="0")||(pt=="3")){
#      UV[lics"\t"mac]++;
      cidCount[cid"\t"lics]++;
#      if(cid=="")
#        print $0 > "report/noncid_'$stat_date'";
#      if(setid=="")
#        print $0 > "report/nonsetid_'$stat_date'";
      if(ap=="0"){
        nonAutoVV++;
      }
      else if(ap=="1"){
        autoVV++;
      }
      topSetCount[setid"\t"lics]++;
      VV++;
      if($16~/B/)
        bVV++;
    }
}
}
END{
#print "stat_date","openVV","openUV","exmpVV","exmpUV","autoVV","nonAtVV";
#print "'$stat_date'",openTotalVV,length(openVV),exmpExcpVV,exmpExcpUV,atVV,nonAtVV;
for(cid in cidCount){
  split(cid,a,"\t");
  cidUV[a[1]]++;
  cidVV[a[1]]+=cidCount[cid];
}
for(c in cidUV){
  print cidName[c],cidVV[c],cidUV[c],cidVV[c]/cidUV[c];
}

for(t in topSetCount){
  split(t,b,"\t");
  setUV[b[1]]++;
  setVV[b[1]]+=topSetCount[t];
}
for(s in setUV){
  print setName[s],cidName[cidList[s]],setVV[s],setUV[s] > "report/'$stat_date'/top_set_'$stat_date'";
}
for(u in UV){
  print u > "intermediate/expLics_'$stat_date'";
}
#print "'$stat_date'",VV,length(exmpMacLicsList) >> "test/expmMacLicsReport";
#print "stat_date","VV","nonAuto","autoVV","UV","VV/UV";
print "'$stat_date'",VV,nonAutoVV,autoVV,length(UV),VV/length(UV) >> "report/vv_uv_report.csv";
}
' $logs $vid_info $code_dict $input | sort -t $',' -k4nr,4 > report/$stat_date/cidvv_uv_$stat_date.csv

## vim: set ts=2 sw=2: #

