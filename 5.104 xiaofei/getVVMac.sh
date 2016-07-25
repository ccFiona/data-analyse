############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: getExpLogs.sh,v 0.0 Wed 18 May 2016 06:19:27 PM CST  <tangye> Exp $ 
## 
############################################################################
#
###
# # @date   Wed 18 May 2016 06:19:27 PM CST  
# # @brief 
# #  
# ##
#!/bin/bash

maclist=$1
input=$2
out=$3

echo $input
echo $out

awk 'ARGIND==1 {expVV_count[$1]=$2;}
ARGIND==2 {


for(a in expVV_count){
    if($5==a){
      if($2!="5.0.1.999.2.TY.0.0_Release"){
        openVV_count[a]++;
      }
    }
  }
}

END{
 for(a in expVV_count){
   if(openVV_count[a]=="")
     print a,expVV_count[a],0;
   else
     print a,expVV_count[a],openVV_count[a];
   }
	   }' $maclist $input | sort -n -k2 > $out
## vim: set ts=2 sw=2: #

