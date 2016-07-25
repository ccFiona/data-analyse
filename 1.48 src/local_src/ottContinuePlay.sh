############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottContinuePlay.sh,v 0.0 2016年03月22日 星期二 11时21分14秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottContinuePlay.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月22日 星期二 11时21分14秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2
type=$3

######
# inputs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
# isdebug
# 
# Returns: 0,vv_count,aver
#	   1,cid,cid_vv,aver
#	   2,cid,cid_uv,aver

awk 'BEGIN{FS=OFS="\t";
  idx=5;
  if(!("'$type'"=="mac")){
    idx=4;
  }
}{
  if(NF>=32){
    split($2,a,".");
    aver=a[1]"."a[2];
    act=$3;
    mac=$idx;
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
    plid=$27;
    playsrc=$16;
    pt=$28;
    if(cid==""){
      cid="other";
    }
    if(act=="play"){
      if((pt=="0"||pt=="3")&&playsrc=="I5"){
	vv_count[aver]++;
	cid_vv[aver"\t"cid]++;
	cid_uv[aver"\t"cid"\t"mac]=1;
      }
    }
  }
}END{
  for(ver in vv_count){
    print "0", ver, vv_count[ver];
  }
  for(key in cid_vv){
    #split(key,a,"\t");
    print "1",key, cid_vv[key];
  }
  for(key in cid_uv){
    split(key,b,"\t");
    cid_uv_sum[b[1]"\t"b[2]]++;
  }
  for(key in cid_uv_sum){
    #split(key,c,"\t");
    print "2",key,cid_uv_sum[key];
  }
}' $input | sort -k1,1 > $out
## vim: set ts=2 sw=2: #

