############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getSuuidMatch.sh,v 0.0 2016年06月07日 星期二 09时25分02秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getSuuidMatch.sh 
# # @date   2016年06月07日 星期二 09时25分02秒  
# # @brief 
# #  
# ##
#!/bin/bash

####
# input1: suuidList (playLenReport/*)
# input2: intermediate/playStopLogs_yesterday|tomorrow {act,lics,suuid,vid,td}
# input2: vvlog {ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,...}
# out: matchCount

list=$1
log=$2
date=$3
name=$4

echo $name

awk '
BEGIN{FS=OFS="\t";}
ARGIND==1 {suuidList[$1]=0;}
ARGIND==2 {
#act=$1;
#suuid=$3;
#vid=$4;
#td=$5;
suuid=$9;
aver=$2;
if(suuid in suuidList){
#  suuidMatch[suuid]++;
  abnormalAver[aver]++;
}
}
END{
#for(s in suuidMatch){
#  print s,suuidMatch[s];
#}
for(s in abnormalAver){
  print s,abnormalAver[s];
}
#print "'$date'","'$name'",length(suuidList),length(suuidMatch) >> "playLenReport/matchStat";
}
' $list $log | sort -k2nr,2 > playLenReport/$name$date

## vim: set ts=2 sw=2: #

