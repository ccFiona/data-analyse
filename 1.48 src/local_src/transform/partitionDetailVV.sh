############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: partitionDetailVV.sh,v 0.0 2016年03月17日 星期四 16时07分44秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   partitionDetailVV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 16时07分44秒  
# # @brief 
# #  
# ##
#!/bin/bash

###########
# input: cid, mac, vid, vv
#
# return: label(0), cid, mac/vid, vv

input=$1
yesterday=$2
type=$3

awk 'BEGIN{FS=OFS="\t";
  idx=3
  if("'$type'"=="user"){
    idx=2
  }
}{
  if(NF>=4){
    vv[0"\t"$1"\t"$idx]+=$4
  }
}END{
  for(key in vv){
    print key, vv[key]
  }
}' $input > ../../../../user_tracking/${type}_vv_$yesterday

## vim: set ts=2 sw=2: #

