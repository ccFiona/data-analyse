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
# Returns: 0,plid,vv,uv,avgvv
#	   1,vid,vv,uv,avgvv
#	   2,plid,continueNum,uv,avgContinueNum
#	   3,cid,vv,uv,avgvv
#	   4,cid,continueNum,uv,avgContinueNum
#	   9,avgvv,vv,uv

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
    plid=$11;
    vid=$22;
    playsrc=$16;
    pt=$28;
    if(cid==""){
      cid="other";
    }
    if(act=="play"&&(pt=="0"||pt=="3")&&playsrc=="I5"){
      if(plid!=""){
	plid_vv_count[plid]++;
	plid_uv_count[plid"\t"mac]++;
      }
      if(vid!=""){
	vid_vv_count[vid]++;
	vid_uv_count[vid"\t"mac]++;
      }
      cid_vv_count[cid]++;
      cid_uv_count[cid"\t"mac]++;
      allvv++
      alluv[mac]++;
    }
  }
}END{
  for(key in plid_uv_count){
    split(key,a,"\t");
    plid_uv_num[a[1]]++;
  }
  for(key in vid_uv_count){
    split(key,b,"\t");
    vid_uv_num[b[1]]++;
  }
  for(key in cid_uv_count){
    split(key,c,"\t");
    cid_uv_num[c[1]]++;
  }
  for(plid in plid_vv_count){
    if(plid in plid_uv_num){
      print "0",plid,plid_vv_count[plid],plid_uv_num[plid],(plid_vv_count[plid]/plid_uv_num[plid])
    }
    else{
      print "0",plid,plid_vv_count[plid],0,0
    }
  }
  for(vid in vid_vv_count){
    if(vid in vid_uv_num){
      print "1",vid,vid_vv_count[vid],vid_uv_num[vid],(vid_vv_count[vid]/vid_uv_num[vid])
    }
    else{
      print "1",vid,vid_vv_count[vid],0,0
    }
  }
  for(cid in cid_vv_count){
    if(cid in cid_uv_num){
      print "3",cid,cid_vv_count[cid],cid_uv_num[cid],(cid_vv_count[cid]/cid_uv_num[cid])
    }
    else{
      print "3",cid,cid_vv_count[cid],0,0
    }
  }
  for(u in alluv){
    alluv_num++
  }
  if(alluv_num>0){
    print "9",allvv/alluv_num, allvv, alluv_num
  }else{
    print "9", 0, allvv, 0
  }
}' $input | sort -k1,1 > continue_vv_tmp

python ottContinuePlayTrigger.py $input  trigger_tmp

cat continue_vv_tmp trigger_tmp | sort -k1,1 -k3rn,3 > $out
## vim: set ts=2 sw=2: #

