############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getPV_VV_time.sh,v 0.0 2016年06月17日 星期五 12时41分21秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getPV_VV_time.sh 
# # @brief 
# #  
# ##
#!/bin/bash

#####
# input: ip, aver, act, lics, mac, time,……

pv=$1
vv=$2
date=$3

awk '
BEGIN{FS=OFS="\t";}
{
lics=$4;
time=$6;
if(lics!="" && time!="")
  print lics,time;
}
' $pv $vv > useLenReport/pv_vv_tmp_$date
## vim: set ts=2 sw=2: #

