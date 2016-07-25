############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottActiveUser.sh,v 0.0 2016年03月16日 星期三 17时49分09秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottActiveUser.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 17时49分09秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2
type=$3


##########
# all inputs: ip, aver, act, lics, mac, time, sver, net...
#
# returns: aver, mac

awk 'BEGIN{FS=OFS="\t";
  idx=5;
  if(!("'$type'"=="mac")){
    idx=4;
  }
}{
  if(NF>=5){
    aver=$2;
    mac=$idx;

    user[aver"\t"mac]=1
  }
}END{
  for(u in user){
    print u;
  }
}' $input | sort -k1,1 > $out

## vim: set ts=2 sw=2: #

