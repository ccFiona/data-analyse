############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getPlayLen.sh,v 0.0 Mon 23 May 2016 02:41:25 PM CST  <tangye> Exp $ 
## 
############################################################################
#
###
# # @brief 
# #  
# ##
#!/bin/bash

####
# input1:intermediate/start{ip, aver, act, lics, mac, time, sver, net,pagename, mf, mod, uuid, isdebug}
# input2:pv_vv_tmp{lics,time}
# input3:date

# return: {dau,suuid_count,ps_count,p_count,s_count}

input=$1
pv_vv=$2
rep_date=$3

awk '
BEGIN{FS=OFS="\t";
beginStr="'$rep_date'""000000";
endStr="'$rep_date'""235959";
begin=mktime(substr("'$rep_date'",0,4)" "substr("'$rep_date'",5,2)" "substr("'$rep_date'",7,2)" 00 00 00");
end=mktime(substr("'$rep_date'",0,4)" "substr("'$rep_date'",5,2)" "substr("'$rep_date'",7,2)" 23 59 59");
}
ARGIND==1 {
    act=$3;
#    mac=$5;
    mac=$4;
    timeLong=$6;

    if(timeLong <= endStr && timeLong >= beginStr){
    time=mktime(substr(timeLong,0,4)" "substr(timeLong,5,2)" "substr(timeLong,7,2)" "substr(timeLong,9,2)" "substr(timeLong,11,2)" "substr(timeLong,13));
    if(act=="start"){
      uv[mac]=1;
      startCount[mac]++;
      startTimes[mac"\t"startCount[mac]]=time;
    }
    else if(act=="quit"){
      uv[mac]=1;
      quitCount[mac]++;
      quitTimes[mac"\t"quitCount[mac]]=time;
    }
  }

}
ARGIND==2{
  mac=$1;
  timeLong=$2;
  uv[mac]=1;
  if(timeLong <= endStr && timeLong >= beginStr){
    time=mktime(substr(timeLong,0,4)" "substr(timeLong,5,2)" "substr(timeLong,7,2)" "substr(timeLong,9,2)" "substr(timeLong,11,2)" "substr(timeLong,13));
    if(startCount[mac] > quitCount[mac]){
      timeCount[mac]++;
      timeList[mac"\t"timeCount[mac]]=time;
    }
  }
}
END{
for(m in uv){
  if(startCount[m]==quitCount[m]){
    matchCount++;
    if(startCount[m]==""){
      useLen[m]=86400;
      useLenTotal+=useLen[m];
      matchNon++;
#      print m,useLen[m] > "useLenReport/allDayLics_'$rep_date'";
      print m,useLen[m] > "useLenReport/licsUseLen_'$rep_date'.csv";
      matchLenTotal+=useLen[m];
    }
    if(startCount[m] > 0 && startCount[m]< 100){
      delete startMacTimes;
      delete sOrder;
      delete quiteMacTimes;
      delete qOrder;
      for(i=1;i<=startCount[m];i++){
        startMacTimes[i]=startTimes[m"\t"i];
        quiteMacTimes[i]=quitTimes[m"\t"i];
      }
      slen=asort(startMacTimes,sOrder);
      slen=asort(quiteMacTimes,qOrder);
      for(i=1;i<=slen;i++){
        if(qOrder[i]-sOrder[i] >=0 ){
          useLen[m]+=qOrder[i]-sOrder[i];
        }
      }
      if(useLen[m] <= 86399  && useLen[m] >= 0){
        useLenTotal+=useLen[m];
        matchLenTotal+=useLen[m];
        matchLenNoml++;
#        print m,useLen[m] > "useLenReport/matchMacUseLen_'$rep_date'";
        print m,useLen[m] > "useLenReport/licsUseLen_'$rep_date'.csv";
      }
    }
    else{
      matchOpeAbnoml++;
    }
#    print m,useLen[m],startCount[m] > "useLenReport/matchMacStart_'$rep_date'";
  }
  else if(startCount[m] > quitCount[m]){
    slCount++;
#    print m,startCount[m],quitCount[m] > "useLenReport/startMacStart_'$rep_date'";

      delete startMacTimes;
      delete sOrder;
      delete quiteMacTimes;
      delete qOrder;
      for(i=1;i<=startCount[m];i++){
        startMacTimes[i]=startTimes[m"\t"i];
        quiteMacTimes[i]=quitTimes[m"\t"i];
      }
      slen=asort(startMacTimes,sOrder);
      slen=asort(quiteMacTimes,qOrder);

    delete timeMacList;
    delete orderList;
    for(i=1;i<=timeCount[m];i++){
      timeMacList[i]=timeList[m"\t"i];
    }
    asort(timeMacList,orderList);
  
    if(quitCount[m] == 0){
      quitNonCount++;
      for(i=1;i<startCount[m];i++){
        maxTime=sOrder[i];
        for(j=1;j<=timeCount[m];j++){
          if(orderList[j] <= sOrder[i+1] && orderList[j] >= sOrder[i]){
            maxTime=orderList[j];
          }
          else if(orderList[j] > sOrder[i+1]){
            break;
          }
        }
        useLen[m]+=maxTime-sOrder[i];
      }
      if(sOrder[startCount[m]] < orderList[timeCount[m]]){
        useLen[m]+=orderList[timeCount[m]]-sOrder[startCount[m]];
      }
      if(useLen[m] <= 86399 && useLen[m] >= 0){
        useLenTotal+=useLen[m];
        nonMatchLenTotal+=useLen[m];
        quitNonLenNoml++;
        print m,useLen[m] > "useLenReport/licsUseLen_'$rep_date'.csv";
      }
#      print m,useLen[m] > "useLenReport/startNonQuitMacUseLen_'$rep_date'";
    }
    else{
      for(i=1;i<startCount[m];i++){
        for(j=1;j<=quitCount[m];j++){
          if(sOrder[i] <= qOrder[j] && sOrder[i+1] >= qOrder[j]){
            useLen[m]+=qOrder[j]-sOrder[i];
            break;
          }
          else if(sOrder[i+1] < qOrder[j]){

        maxTime=sOrder[i];
        for(k=1;k<=timeCount[m];k++){
          if(orderList[k] <= sOrder[i+1] && orderList[k] >= sOrder[i]){
            maxTime=orderList[k];
          }
          else if(orderList[k] > sOrder[i+1]){
            break;
          }
        }
        useLen[m]+=maxTime-sOrder[i];

            break;
          }
        }
      }
      if(sOrder[startCount[m]] < orderList[timeCount[m]] && sOrder[startCount[m]] > qOrder[quitCount[m]]){
        useLen[m]+=orderList[timeCount[m]]-sOrder[startCount[m]];
      }
      slQuitCount++;

      if(useLen[m] <= 86399 && useLen[m] >= 0){
        useLenTotal+=useLen[m];
        nonMatchLenTotal+=useLen[m];
        slQuitLenNom++;
        print m,useLen[m] > "useLenReport/licsUseLen_'$rep_date'.csv";
      }
#      print m,useLen[m] > "useLenReport/startQuitMacUseLen_'$rep_date'";
    }
  }
  else{
    qlCount++;
#    print m,startCount[m],quitCount[m] > "useLenReport/quitMacStart_'$rep_date'";
  }
}
print "stat_date", "dau","len/u","match","mNone","mNoml","mLen/u","start","qNCount","qNLenNl","sQCount","sQLenNl","sLen/u","quitCount" >>"useLenReport/useLenReport";
#print "'$rep_date'",length(uv),(playLen)/(length(uv)*60),length(suuidList),wCount,abCount,sCount,sNorCount,pCount,oCount >> "playLenReport/playLenReport";
print "'$rep_date'",length(uv),(useLenTotal)/((matchNon+matchLenNoml+quitNonLenNoml+slQuitLenNom)*60),matchCount,matchNon,matchLenNoml,(matchLenTotal)/((matchNon+matchLenNoml)*60),slCount,quitNonCount,quitNonLenNoml,slQuitCount,slQuitLenNom,(nonMatchLenTotal)/((quitNonLenNoml+slQuitLenNom)*60),qlCount >> "useLenReport/useLenReport";
}
' $input $pv_vv 
## vim: set ts=2 sw=2: #

