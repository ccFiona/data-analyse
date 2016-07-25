############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottAd.sh,v 0.0 2016年03月17日 星期四 09时26分38秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   ottAd.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 09时26分38秒  
# # @brief 
# #  
# ##
#!/bin/bash

input=$1
out=$2

############
# input: ip, aver, act, lics, mac, time, sver, net, mf, mod,
# pagename,
# act=adplay: ad_status, vid, at, aid, ad_num, ad_pre_num, ad_index,
# ad_total_time, ad_start, ad_end
# act=aderror: err, perr, vid, at, aid, param, response, errorMessage,
# errorDesc, type, cid
#
# returns: act=adplay, total_count, success_count, error_count, quit_count


awk 'BEGIN{FS=OFS="\t"}{
  if(NF>=21){
    act=$3;
    if(act=="adplay"){
      total_count++;
      status=$12;
      if(status=="1"){
        success_count++;
      }
      if(status=="2"){
        error_count++;
      }
      if(status=="3"){
        quit_count++;
      }
    }
  }
}END{
  print total_count, success_count, error_count, quit_count;
}' $input > $out
## vim: set ts=2 sw=2: #

