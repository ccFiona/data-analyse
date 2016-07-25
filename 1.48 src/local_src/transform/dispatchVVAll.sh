############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: dispatchVV.sh,v 0.0 2016年03月17日 星期四 15时41分01秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   dispatchVV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 15时41分01秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
yesterday=$2
ver=$3

###########
# input: ver, act, playsrc, vv, nonauto_vv
#
# returns: act, playsrc, vv, nonauto_vv

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=5){
    vv[$2"\t"$3]+=$4
    nonauto_vv[$2"\t"$3]+=$5
  }
}END{
  for(key in vv){
    if(key in nonauto_vv){
      print key, vv[key], nonauto_vv[key];
    }else{
      print key, vv[key], 0;
    }
  }
}' $input | sort -k1,2  > ../../../../stat_$ver/vv_allvers_$yesterday


## vim: set ts=2 sw=2: #

