############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getPlayLen.sh,v 0.0 Mon 23 May 2016 02:41:25 PM CST  <tangye> Exp $ 
## 
############################################################################
#
###
# # @brief 
# #  
# ##
#!/bin/bash

####
# or_logs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug
#
# inputs: act,lics,suuid,vid,td
# return: (vedio_play_len > 5*td logs)vid,vedio_length,play_length 


len=$1
input=$2
out=$3

awk '
BEGIN{FS=OFS="\t";}
ARGIND==1 {vlen[$1]=$2;}
ARGIND==2 {
    act=$1;
    suuid=$3;
    vids[suuid]=$4;
    td=$5;
    suuidList[suuid]++;
    if(act=="play"){
      playCount[suuid]++;
    }
    else{
      stList[suuid]=td;
      stopCount[suuid]++;
    }
}END{
for(s in suuidList){
  if((stopCount[s]==1)&&(playCount[s]==1)&&(stList[s]>5*vlen[vids[s]])){
    print s,vids[s],vlen[vids[s]],stList[s];
  }
  }
}
' $len $input|sort -t $'\t' -k4rn,4 > $out
## vim: set ts=2 sw=2: #

