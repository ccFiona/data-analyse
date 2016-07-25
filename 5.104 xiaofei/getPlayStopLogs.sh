############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getPlayLen.sh,v 0.0 Mon 23 May 2016 12:06:59 PM CST  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getPlayStopLogs.sh 
# # @date   Mon 23 May 2016 12:06:59 PM CST  
# # @brief 
# #  
# ##
#!/bin/bash

####
# inputs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
# isdebug
# 
# Returns: act,lics,suuid,vid,td,cid,time


input=$1
out=$2

awk '
BEGIN{FS=OFS="\t";}
{
  act=$3;
  lics=$4;
  suuid=$9;
  vid=$12;
  td=$14;
  cid=$10;
  time=$6;
  if((act=="play")||(act=="stop")||(act=="pause")||(act=="resume")){
    print act,lics,suuid,vid,td,cid,time;
    #usrnum[lics]++;
  }
}

' $input > $out
## vim: set ts=2 sw=2: #
