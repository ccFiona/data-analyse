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
# input1: intermediate/expLicsAll
# input2: all_logs
# input3: report/vid_info {setid,setname,vid}
# input4: report/code_dict {cid,cidname}
# input5: orig_logs{ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,...
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug}
# input6: stat_date

# out1:"expmMacLicsUV_'$stat_date'"
# out2:

expLics=$1
logs=$2
vid_info=$3
code_dict=$4
input=$5
stat_date=$6

cd /data/dev/xiaofei

awk 'BEGIN{FS="\t";OFS=","}
ARGIND==1 {expLicsList[$1]=1;}
ARGIND==2 {
aver=$2;
lics=$4;
mac=$5;
if(lics in expLicsList)
  UV[lics]=1;
}
ARGIND==3 {
setName[$1]=$2;
cidList[$1]=$3;
}
ARGIND==4 {
cidName[$1]=$2;
}
ARGIND==5 {
aver=$2;
act=$3;
lics=$4;
mac=$5;
#cid=$10;
setid=$11;
cid=cidList[setid];
pt=$28;
ap=$26;
if(lics in expLicsList){
    UV[lics]=1;
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
      print $0 > "report/vv_tmp_'$stat_date'";
    }
}
}
END{
for(cid in cidCount){
  split(cid,a,"\t");
  cidUV[a[1]]++;
  cidVV[a[1]]+=cidCount[cid];
}
for(c in cidUV){
  if(cidUV[c] != 0){
    print cidName[c],cidVV[c],cidUV[c],cidVV[c]/cidUV[c];
  }
  else{
    print cidName[c],cidVV[c],cidUV[c],"";
  }
}

for(t in topSetCount){
  split(t,b,"\t");
  setUV[b[1]]++;
  setVV[b[1]]+=topSetCount[t];
}
for(s in setUV){
  print setName[s],cidName[cidList[s]],setVV[s],setUV[s] > "report/'$stat_date'/his_top_set_'$stat_date'";
}
if(length(UV) != 0){
  print "'$stat_date'",VV,nonAutoVV,autoVV,length(UV),VV/length(UV) >> "report/his_vv_uv_report.csv";
}
else
  print "'$stat_date'",VV,nonAutoVV,autoVV,length(UV),"" >> "report/his_vv_uv_report.csv";
}
' $expLics $logs $vid_info $code_dict $input | sort -t $',' -k4nr,4 > report/$stat_date/his_cidvv_uv_$stat_date.csv

## vim: set ts=2 sw=2: #

