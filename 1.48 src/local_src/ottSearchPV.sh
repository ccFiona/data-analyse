############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottSearchPV.sh,v 0.0 2016年03月23日 星期三 10时26分01秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottSearchPV.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月23日 星期三 10时26分01秒  
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
# returns: pagename, pv, uniq_pv, timedelta, morethan30_num, aver


awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=22){
    split($2,a,".");
    aver=a[1]"."a[2];
    act=$3;
    pagename=$11;
    ext1=$12;
    ext7=$18;
    ext10=$21;
    if(act=="pageload"){
      if(ext7~/^[0-9]+$/){
	if(pagename!=""&&ext10!=""){
	  if(ext1=="1"){
	    timedelta[aver"\t"pagename]+=ext7
	    allTimedelta[pagename]+=ext7
	    if(ext7>1800){
	      halfhour_num[aver"\t"pagename]++
	      allHalfhour_num[pagename]++
	    }
	  }
	  if(ext1=="0"){
	    pv[aver"\t"pagename]++;
	    allPv[pagename]++
	    uniq_pv[aver"\t"pagename"\t"ext10]=1
	    allUniq_pv[pagename"\t"ext10]=1
	  }
	}
      }
    }
  }
}END{
  for(key in uniq_pv){
    split(key,a,"\t")
    ver=a[1]"\t"a[2]
    uniq_pv_num[ver]++
  }
  for(key in pv){
    uniqpv=0
    times=0
    halfnum=0
    if(key in uniq_pv_num){
      uniqpv=uniq_pv_num[key]
    }
    if(key in timedelta){
      times=timedelta[key]
    }
    if(key in halfhour_num){
      halfnum=halfhour_num[key]
    }
    print key, pv[key], uniqpv, times, halfnum
  }
  for(key in allUniq_pv){
    split(key,b,"\t")
    pagename=b[1]
    allUniq_pv_num[pagename]++
  }
  for(key in allPv){
    uniqpv=0
    times=0
    halfnum=0
    if(key in allUniq_pv_num){
      uniqpv=allUniq_pv_num[key]
    }
    if(key in allTimedelta){
      times=allTimedelta[key]
    }
    if(key in allHalfhour_num){
      halfnum=allHalfhour_num[key]
    }
    print "all", key, allPv[key], uniqpv, times, halfnum
  }
}' $input | sort -k1,1 > $out


## vim: set ts=2 sw=2: #

