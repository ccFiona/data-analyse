############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: experimentalUserDivide.sh,v 0.0 2016年05月19日 星期四 11时43分20秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   experimentalUserDivide.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月19日 星期四 11时43分20秒  
# # @brief 
# #  
# ##
#!/bin/bash

all_mac=$1
input=$2
out=$3
aver=$4

awk 'BEGIN{FS=OFS="\t"}
ARGIND==1{
  e_mac[$2]=1
}
ARGIND==2{
  ver[$1]=1
}
ARGIND==3{
  if($2 in e_mac){
    if($1 in ver){
      ty_ver[$2]=1
    }else{
      other_ver[$2]=1
    }
  }
}
END{
  for(m in e_mac){
    if(m in ty_ver){
      if(m in other_ver){
        both_count++
      }else{
        ty_count++
      }
    }else{
      if(m in other_ver){
        other_count++
      }
    }
  }
  print "both", both_count
  print "ty", ty_count
  print "other", other_count
}' $all_mac $aver $input > $out 
## vim: set ts=2 sw=2: #

