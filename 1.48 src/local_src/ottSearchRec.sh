############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottSearch.sh,v 0.0 2016年03月16日 星期三 23时21分08秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottSearch.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月16日 星期三 23时21分08秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2


###########
# input: ip, aver, act, lics, mac, time, sver, net, mf, mod,
# pagename, ext1 ~ ext10
# isdebug
#
# returns: 0, key, count
#          1, plid, count
#          count, aver, count
#          searchCount, aver, count
#          noResultCount, aver, count


awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=22){
    split($2,a,".");
    aver=a[1]"."a[2];
    act=$3;
    ext1=$12;
    ext2=$13;
    ext3=$14;
    ext5=$16;
    ext7=$18;
    ext8=$19;
    suuid=$21;
    last_suuid=$20;

    pagename=$11;
    if(act=="dataload"){
      if(ext1=="0"&&ext7=="1"){
	if(ext8=="0"){
	  nonResultUuid[suuid]=1;
	}
      }
    }
    if(act=="pageload"){
      if(pagename=="C"&&ext3=="D2"){
	detailPVSrcUuid[last_suuid"\t"suuid];
      } 
    }
  }
}END{
  for(key in detailPVSrcUuid){
    split(key,a,"\t")
    detailPv[a[1]]++;
  }
  for(s in detailPv){
    if(s in nonResultUuid){
      nonResultClick++;
    }
  }
  print nonResultClick;
}' $input > $out

## vim: set ts=2 sw=2: #

