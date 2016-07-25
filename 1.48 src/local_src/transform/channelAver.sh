############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: channelAver.sh,v 0.0 2016年03月23日 星期三 10时07分37秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   channelAver.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月23日 星期三 10时07分37秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2

#######
# input: 1, channel, aver, vv
awk 'BEGIN{FS=OFS="\t"}{
  if($1=="1"){
    print $2,$3,$4
  }
}' $input > $out
## vim: set ts=2 sw=2: #

