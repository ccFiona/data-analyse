############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getVV.sh,v 0.0 Fri 20 May 2016 09:47:30 AM CST  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getVV.sh 
# # @date   Fri 20 May 2016 09:47:30 AM CST  
# # @brief 
# #  
# ##
#!/bin/bash

#####
# inputs:mac,expVV,openVV
# out:expVV,openVV,uv|DAU

input=$1
out=$2
dt=$3

echo $input
echo $out
echo $dt

awk '
#BEGIN{FS=OFS="\t";}
{
  a[1]+=$2;
  a[2]+=$3;
  a[3]++;
} END{
print "'$dt'",a[1],a[2],a[3];
}' $input >> $out
## vim: set ts=2 sw=2: #

