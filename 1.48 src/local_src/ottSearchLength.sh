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
    lics=$4;
    ext1=$12;
    ext2=$13;
    ext3=$14;
    ext5=$16;
    ext7=$18;
    ext8=$19;
    pagename=$11;
    if(act=="dataload"){
      if(ext1=="0"&&ext7=="1"){
	if(ext8=="0"){
	  nonResultCount[aver]++;
	}
	searchCount[aver]++;
	if(ext5!=""){
	  searchKey[aver"\t"ext5]++;
	}
	lics_dict[aver"\t"lics]=1;
      }
    }
    if(act=="onfocus"){
      if(ext1=="1"){
	counts[aver]++;
      }
    }
    if(act=="pageload"){
      if(ext2=="D"&&pagename=="C"&&ext3!=""){
	split(ext3,a,"&");
	lastpage=a[1];
	if(lastpage=="D2"){
	  if(ext8!=""){
	    split(ext8,b,"&");
	    for(i in b){
	      split(b[i],c,"=");
	      if(c[1]=="videoid"&&2 in c){
		searchVideo[c[2]]++;
		delete c;
		break;
	      }
	      delete c;
	    }
	    delete b;
	  }
	}
	delete a;
      } 
    }
  }
}END{
  for(ver in searchCount){
    print "searchCount", ver, searchCount[ver];
  }
  for(ver in nonResultCount){
    print "nonResultCount", ver, nonResultCount[ver];
  }
  for(ver in counts){
    print "count", ver, counts[ver];
  }
  for(key in searchKey){
    print "0", key, searchKey[key];
  }
  for(vid in searchVideo){
    print "1", vid, searchVideo[vid];
  }
  for(lics in lics_dict){
    split(lics,a,"\t")
    lics_sum[a[1]]++;
  }
  for(v in lics_sum){
    print "lics", v, lics_sum[v];
  }
}' $input | sort -k1,1 -k3rn,3 | awk 'BEGIN{FS=OFS="\t";count_a=0;count_b=0;}{
  if($1=="0"){
    len_dict[$2"\t"length($3)]+=$4
  }
  if($1=="lics"){
    print $0;
  }
}END{
  for(l in len_dict){
    print l, len_dict[l]
  }
}' | sort -k1,1 > $out

## vim: set ts=2 sw=2: #

