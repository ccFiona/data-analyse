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
#
# stat: (vedio_play_len > 5*td logs)suuid,vid,vedio_length,play_length
#
# inputs: ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,isdebug
# return: (vedio_play_len > 5*td logs)


stat=$1
input=$2
out=$3

awk '
BEGIN{FS=OFS="\t";}
ARGIND==1 {suuidList[$1]=$3;}
ARGIND==2 {
act=$3;
suuid=$9;
if(act=="stop"){
  if(suuid in suuidList){
  vedio_len=suuidList[suuid];
  print vedio_len,$14,$0;
}
}
}
' $stat $input|sort -t $'\t' -k16rn,16 > $out
## vim: set ts=2 sw=2: #

