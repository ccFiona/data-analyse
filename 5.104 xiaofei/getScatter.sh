############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getPlayLenScatter.sh,v 0.0 2016年06月23日 星期四 09时37分01秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getPlayLenScatter.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年06月23日 星期四 09时37分01秒  
# # @brief 
# #  
# ##
#!/bin/bash

#########
# input:playLenReport/licsPlayLen_20160607

licsPlayLen=$1
type=$2
date=$3

awk '
BEGIN{FS=OFS="\t";}
{
  t=$2;
  if(t>=0&&t<=600)
    a1++;
  else if(t>600&&t<=1800)
    a2++;
  else if(t>1800&&t<=3600)
    a3++;
  else if(t>3600&&t<=7200)
    a4++;
  else if(t>7200&&t<=14400)
    a5++;
  else if(t>14400&&t<=21600)
    a6++;
  else if(t>21600&&t<=28800)
    a7++;
  else if(t>28800&&t<=36000)
    a8++;
  else if(t>36000&&t<=43200)
    a9++;
  else if(t>43200&&t<=50400)
    a10++;
  else if(t>50400&&t<=57600)
    a11++;
  else if(t>57600&&t<=64800)
    a12++;
  else if(t>64800&&t<=72000)
    a13++;
  else if(t>72000&&t<=79200)
    a14++;
  else if(t>79200&&t<86400)
    a15++;
  else if(t==86400)
    a16++;
}
END{
print "'$date'","'$type'",a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16 >> "playLenReport/scatter.csv";
}' $licsPlayLen
## vim: set ts=2 sw=2: #

