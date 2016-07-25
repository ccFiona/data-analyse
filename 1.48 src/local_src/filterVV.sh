############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: filterVV.sh,v 0.0 2016年04月14日 星期四 15时06分12秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   filterVV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年04月14日 星期四 15时06分12秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1

awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=32){
    cid=$10;
    if($10=="vstartek_tv"){
      cid="TVseries";
    }
    if($10=="vstartek_film"){
      cid="movie";
    }
    if($10=="vstartek_arts"){
      cid="variety";
    }
    if($10=="vstartek_documentary"){
      cid="documentary";
    }
    if($10=="vstartek_anime"){
      cid="animation";
    }
    ret=$1;
    for(i=2;i<10;i++){
      ret=ret"\t"$i;
    }
    ret=ret"\t"cid;
    for(i=11;i<=NF;i++){
      ret=ret"\t"$i;
    }
    print ret

  }
}' $input > tmp

mv tmp $input
## vim: set ts=2 sw=2: #

