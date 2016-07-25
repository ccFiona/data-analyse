############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottStart.sh,v 0.0 2016年03月16日 星期三 13时32分07秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottStart.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 13时32分07秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2

########
# inputs:
# ip, aver, act, lics, mac, time, sver, net
# pagename, mf, mod, uuid, isdebug


awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=13){
    start_user[$2]=$5
  }
}END{
  for(u in start_user){
    print u, start_user[u]
  }
}' $input | sort -k1,1 > $out

## vim: set ts=2 sw=2: #

