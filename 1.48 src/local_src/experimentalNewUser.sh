############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: experimentalNewUser.sh,v 0.0 2016年05月19日 星期四 13时10分59秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   experimentalNewUser.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年05月19日 星期四 13时10分59秒  
# # @brief 
# #  
# ##
#!/bin/bash

todayActiveUser=$1
yesterdayUser=$2
todayUser=$3
newUser=$4
aver=$5

rm $newUser

awk 'BEGIN{FS=OFS="\t"}
ARGIND==1{
  ver[$1]=1
}
ARGIND==2{
    if($1 in ver){
      todayActU[$1"\t"$2]=1
      uniqTodayActU[$2]=1
    }
}
ARGIND==3{
    yesterdayU[$1"\t"$2]=1
    uniqYesterdayU[$2]=1
}END{
 for(u in uniqTodayActU){
   if(!(u in uniqYesterdayU)){
     print u>>"'$newUser'"
   }
 }
 for(u in todayActU){
   if(!(u in yesterdayU)){
     print u>>"tmp1"
   }
 }
}' $aver $todayActiveUser $yesterdayUser 

cat tmp1 $yesterdayUser > $todayUser

rm tmp1

## vim: set ts=2 sw=2: #

