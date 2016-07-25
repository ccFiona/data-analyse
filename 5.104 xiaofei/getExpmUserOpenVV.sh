############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpmUserOpenVV.sh,v 0.0 2016年06月03日 星期五 17时24分48秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getExpmUserOpenVV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年06月03日 星期五 17时24分48秒  
# # @brief 
# #  
# ##
#!/bin/bash


####
# input1: test/expmUserVV_today
# input2: inputlogs/lastweek/vv_lastweek
# input3: lastweek_date

user=$1
input=$2
date=$3

awk 'BEGIN{FS=OFS="\t";}
ARGIND==1 {user[$1"\t"$2]=1;}
ARGIND==2 {
aver=$2;
act=$3;
l=$4;
mac=$5;
lics=l"\t"mac;
cid=$10;
pt=$28;
ap=$26;
if((NF>=32)&&(act=="play")&&(pt=="0")||(pt=="3")){
#  if((lics in user)&&(aver!="5.1.104.999.2.TY.0.0_Release")){
  if(lics in user){
    vv++;
    userVV[lics]++;
    averList[lics]=aver;
  }
}
}
END{
print "'$date'",vv,length(userVV) >> "test/openVVStat";
for(v in userVV)
  print v,userVV[v],averList[v];
}
' $user $input | sort -k2nr,2 > test/openUserVV_$date
## vim: set ts=2 sw=2: #

