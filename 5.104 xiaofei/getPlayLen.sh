############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getPlayLen.sh,v 0.0 Mon 23 May 2016 02:41:25 PM CST  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   getPlayLen.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   Mon 23 May 2016 02:41:25 PM CST  
# # @brief 
# #  
# ##
#!/bin/bash

####
# input1:inputlogs/vedio_len{vid,cid,td,seriesNum(clip.id,clip.sndlvl_id,clip.total_duration,clip.series_count)}
# input2:all_logs
# input3:intermediate/playStopLogs_20160505 {act,lics,suuid,vid,td,cid,time}

# return:playLenReport/playLenReport {dau,suuid_count,ps_count,p_count,s_count}

len=$1
logs=$2
input=$3
rep_date=$4

awk '
BEGIN{FS="\t";OFS=",";
beginStr="'$rep_date'""000000";
endStr="'$rep_date'""235959";
}
ARGIND==1 {vlen[$1]=$3;}
ARGIND==2 {uv[$4]=1;}
ARGIND==3 {
    act=$1;
    lics=$2;
    suuid=$3;
    uv[lics]=1;
    vids[suuid]=$4;
    cids[suuid]=$6;
    td=$5;
    timeLong=$7;

    if(timeLong <= endStr && timeLong >= beginStr){
      time=mktime(substr(timeLong,0,4)" "substr(timeLong,5,2)" "substr(timeLong,7,2)" "substr(timeLong,9,2)" "substr(timeLong,11,2)" "substr(timeLong,13));

    licsSuuid[suuid]=$2;
    suuidList[suuid]=1;
    if(act=="play"){
      ptList[suuid]++;
      cidUV[lics"\t"$6]=1;
    }
    else if(act=="stop"){
      stList[suuid]=td;
      stopCount[suuid]++;
      stopTime[suuid]=time;
      #flag[suuid]+=2;
    }
    else if(act=="pause"){
      pauseCount[suuid]++;
      pauseList[suuid"\t"pauseCount[suuid]]=time;
    }
    else if(act=="resume"){
      resumeCount[suuid]++;
      resumeList[suuid"\t"resumeCount[suuid]]=time;
    }
  }
}END{
for(s in suuidList){
  if((stopCount[s]==1)&&(ptList[s]==1)){
    if(stList[s]<=3*vlen[vids[s]] && stList[s]-0 >= 0){
      wCount++;
      playLen+=stList[s];
      cidPlayLen[cids[s]]+=stList[s];

      if(s in pauseCount){
        if(!(s in resumeCount)){
          pauseLen[s]=stopTime[s]-pauseList[s"\t"1]+1;
        }
        else{
          tmp=pauseCount[s];
          if(resumeCount[s]<tmp){
            tmp=resumeCount[s];
            pauseLen[s]+=stopTime[s]-pauseList[s"\t"pauseCount[s]]+1;
          }
          for(i=1;i<=tmp;i++){
            if(resumeList[s"\t"i]-pauseList[s"\t"i]>=0)
              pauseLen[s]+=resumeList[s"\t"i]-pauseList[s"\t"i]+1;
          }
        }
      }

      licsPlayLen[s]=stList[s];
      if(licsPlayLen[s] >= pauseLen[s] && pauseLen[s] > 0){
        licsPlayLen[s]-=pauseLen[s];
      }
    }
    else{
      abCount++;
    }
    print licsSuuid[s],s,stList[s],pauseLen[s] > "playLenReport/matchPauseLen_'$rep_date'";
  }
  else if((stopCount[s]==1)&&(ptList[s]=="")){
    sCount++;
#    print s > "playLenReport/nonplay_'$rep_date'";
    if(stList[s]<=3*vlen[vids[s]] && stList[s]-0 >= 0){
      sNorCount++;
      playLen+=stList[s];
      cidPlayLen[cids[s]]+=stList[s];

      if(s in pauseCount){
        if(!(s in resumeCount)){
          pauseLen[s]=stopTime[s]-pauseList[s"\t"1]+1;
        }
        else{
          tmp=pauseCount[s];
          if(resumeCount[s]<tmp){
            tmp=resumeCount[s];
            pauseLen[s]+=stopTime[s]-pauseList[s"\t"pauseCount[s]]+1;
          }
          for(i=1;i<=tmp;i++){
            if(resumeList[s"\t"i]-pauseListList[s"\t"i]>=0)
              pauseLen[s]+=resumeList[s"\t"i]-pauseListList[s"\t"i]+1;
          }
        }
      }

      licsPlayLen[s]=stList[s];
      if(licsPlayLen[s] >= pauseLen[s] && pauseLen[s] > 0){
        licsPlayLen[s]-=pauseLen[s];
      }
    }
    print licsSuuid[s],s,stList[s],pauseLen[s] > "playLenReport/stopPauseLen_'$rep_date'";
  }
  else if((ptList[s]==1)&&(!(s in stList))){
    pCount++;
    print s > "playLenReport/nonstop_'$rep_date'";
  }
  else if((stopCount[s]>1)||(ptList[s]>1)){
    oCount++;
    print s > "playLenReport/multi_'$rep_date'";
  }
  if(s in licsPlayLen){
    licsTotalLen[licsSuuid[s]]+=licsPlayLen[s];
  }
}
for(cu in cidUV){
  split(cu,a,"\t");
  cUV[a[2]]++;
}
for(l in licsTotalLen){
  print l,licsTotalLen[l] > "playLenReport/licsPlayLen_'$rep_date'";
  if(licsTotalLen[l] > 86400)
    playLen-=licsTotalLen[l];
}
#print "stat_date", "dau","pLen/u","suuid","noml","abnoml","stop","sNorml","play","multi" >> "playLenReport/playLenReport";
#print "'$rep_date'",length(uv),(playLen-pauseTimeTotal)/(length(uv)*60),length(suuidList),wCount,abCount,sCount,sNorCount,pCount,oCount >> "playLenReport/playLenReport";
print "'$rep_date'",length(uv),(playLen)/(length(uv)*60),length(suuidList),wCount,abCount,sCount,sNorCount,pCount,oCount >> "playLenReport/playLenReport.csv";

print "cid","cidUV","playLen/u">"playLenReport/cidPlayLen_'$rep_date'";
for(cpl in cidPlayLen)
  if(cUV[cpl] == "")
    print cpl,cUV[cpl];
  else
    print cpl,cUV[cpl],cidPlayLen[cpl]/(60*cUV[cpl]);
}
' $len $logs $input | sort -t $'\t' -k3nr,3 >> playLenReport/cidPlayLen_$rep_date
## vim: set ts=2 sw=2: #

