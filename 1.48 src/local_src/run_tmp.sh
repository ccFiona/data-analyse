############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: run.sh,v 0.0 2016年03月17日 星期四 11时31分40秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   run.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 11时31分40秒  
# # @brief 
# #  
# ##
#!/bin/bash

############
# transform clean log into local results

today=$1
yesterday=`date -d "1 day ago $today" +%Y%m%d`

input_path=../../data/$yesterday
intermediate_result=../../data/intermediate_result


#sh list_cid_pv.sh $input_path/pv_$yesterday $intermediate_result/list_cid_pv_$yesterday
#sh list_cid_vv.sh $input_path/vv_$yesterday $intermediate_result/list_cid_vv_$yesterday

echo "filter"
#sh filterVV.sh $input_path/vv_$yesterday
#####
# vv
echo "vv"
#sh ottIPS.sh $input_path/vv_$yesterday $intermediate_result/ips_$yesterday
#sh ottVV.sh $input_path/vv_$yesterday $intermediate_result/vv_$yesterday
#sh ottVVNonplaysrc.sh $input_path/vv_$yesterday $intermediate_result/vv_nonplaysrc_$yesterday

####
# vv_uuid
echo "vv_uuid"
#cat $input_path/vv_$yesterday $input_path/qplay_$yesterday > $input_path/vv_qplay_tmp_$yesterday
#sh ottVVUuid.sh $input_path/vv_qplay_tmp_$yesterday $intermediate_result/vv_uuid_$yesterday
#rm $input_path/vv_qplay_tmp_$yesterday

#####
# vv_user_detail
echo "vv_user_detail"
#sh ottUserDetailVV.sh ../../../mysql/code_dict ../../../mysql/vid_info $input_path/vv_$yesterday $intermediate_result/vv_user_detail_$yesterday

####
# start
echo "start"
#sh ottActiveUser.sh $input_path/start_$yesterday $intermediate_result/start_$yesterday mac


#####
# active_user
echo "active_user"
cat $input_path/pv_$yesterday $input_path/start_$yesterday $input_path/error_$yesterday $input_path/vv_$yesterday > $input_path/active_tmp
#sh ottActiveUser.sh $input_path/active_tmp $intermediate_result/active_user_$yesterday mac
sh ottActiveUser.sh $input_path/active_tmp $intermediate_result/active_lics_$yesterday lics
rm $input_path/active_tmp


####
# pv
echo "pv"
#sh ottPV.sh $input_path/pv_$yesterday $intermediate_result/pv_$yesterday

####
# Ad
echo "ad"
#sh ottAd.sh $input_path/ad_$yesterday $intermediate_result/ad_$yesterday

####
# search
echo "search"
#sh ottSearch.sh $input_path/pv_$yesterday $intermediate_result/search_$yesterday 
#sh ottSearchLength.sh $input_path/pv_$yesterday $intermediate_result/search_length_$yesterday 
#sh ottSearchRec.sh $input_path/pv_$yesterday $intermediate_result/search_rec_$yesterday

####
# search_pv
echo "search_pv"
#sh ottSearchPV.sh $input_path/pv_$yesterday $intermediate_result/search_pv_$yesterday

#######
# watch_uv
echo "watch_uv"
#sh ottUVDAU.sh $input_path/vv_$yesterday $intermediate_result/watch_uv_$yesterday mac
#sh ottUVDAU.sh $input_path/vv_$yesterday $intermediate_result/watch_uv_lics_$yesterday 


#######
# watch_hour
echo "watch_hour"
#sh ottVVHour.sh $input_path/vv_$yesterday $intermediate_result/vv_hour_$yesterday


#######
# MH
echo "MH"
#sh ottMH.sh $input_path/vv_$yesterday $intermediate_result/mh_$yesterday


######
# continue play
echo "continue play"
#sh ottContinuePlay.sh $input_path/vv_$yesterday $intermediate_result/simple_continue_play_$yesterday mac
#sh ottContinuePlayNew.sh $input_path/vv_$yesterday $intermediate_result/continue_play_$yesterday mac


experimentalAver=experimental_ver
lastdate=`date -d "1 day ago $yesterday" +%Y%m%d`
sh experimentalNewUser.sh $intermediate_result/active_lics_$yesterday $intermediate_result/experimental/all_mac_$lastdate $intermediate_result/experimental/all_mac_$yesterday $intermediate_result/experimental/new_mac_$yesterday $experimentalAver
sh experimentalUserDivide.sh $intermediate_result/experimental/all_mac_$yesterday $intermediate_result/active_lics_$yesterday $intermediate_result/experimental/experimental_user_divide_$yesterday $experimentalAver
#sh experimentalVV.sh $intermediate_result/experimental/all_mac_$yesterday $input_path/vv_$yesterday $intermediate_result/experimental/vv_$yesterday lics
#sh experimentalVV_log.sh $intermediate_result/experimental/all_mac_$yesterday $input_path/vv_$yesterday $intermediate_result/experimental/vv_log_$yesterday $experimentalAver

## vim: set ts=2 sw=2: #

