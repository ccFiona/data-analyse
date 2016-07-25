############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: experimentalVV.sh,v 0.0 2016年05月19日 星期四 14时50分10秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   experimentalVV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月19日 星期四 14时50分10秒  
# # @brief 
# #  
# ##
#!/bin/bash

activeUser=$1
input=$2
out=$3
aver=$4


awk 'BEGIN{FS=OFS="\t"}
ARGIND==1{
  e_mac[$2]=1
}
ARGIND==2{
  if(NF>=32){
    aver=$2
    act=$3
    pt=$28
    mac=$5

    if(pt==""){pt="null"}

    if((mac in e_mac)&&act=="play"&&((pt=="0")||(pt=="3"))){
      print $0
    }
  }
}END{
}
' $activeUser $input | sort -k2rn,2 > $out


## vim: set ts=2 sw=2: #

