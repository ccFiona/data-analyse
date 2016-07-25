############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: dispatchVVUuid.sh,v 0.0 2016年03月17日 星期四 16时27分58秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   dispatchVVUuid.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 16时27分58秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
yesterday=$2
ver=$3

###########
# input: ver, uuid, act, count
#
# returns: uuid, act, count

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=4&&$1=="'$ver'"){
    print $2,$3,$4
  }
}' $input > ../../../../stat_$ver/uuid_vv_$yesterday

## vim: set ts=2 sw=2: #

