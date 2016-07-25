############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getConsistUser.sh,v 0.0 2016年06月01日 星期三 13时40分18秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getConsistUser.sh 
# # @date   2016年06月01日 星期三 13时40分18秒  
# # @brief 
# #  
# ##
#!/bin/bash

###
# input1: $inter_path/vv_expOnlyMac_$tem 
# input2: $inter_path/vv_expOnlyMac_$tem_tm 
# input3: date $tem_tm
#
# output: $inter_path/expConsist_$tem_tm

firstDayUser=$1
secDayUser=$2
date=$3

awk 'BEGIN{FS=OFS="\t";}
ARGIND==1 {firstUsers[$1]=1;}
ARGIND==2 {
   if($1 in firstUsers)
     print $1;
}
' $firstDayUser $secDayUser > intermediate/expConsistUsers_$date

## vim: set ts=2 sw=2: #

