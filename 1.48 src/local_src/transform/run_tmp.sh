############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: transform.sh,v 0.0 2016年03月17日 星期四 15时24分21秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   transform.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月17日 星期四 15时24分21秒  
# # @brief 
# #  
# ##
#!/bin/bash

##############
# prepare local results to reports input


today=$1
yesterday=`date -d "1 day ago $today" +%Y%m%d`

intermediate_result=../../../data/intermediate_result

syn_path=../../../../daily_report/$yesterday

###########
# first part data
###########

########
# mv start & active_user
#mv $intermediate_result/start_$yesterday ../../../../stat_4.x/ott_start_$yesterday
#mv $intermediate_result/active_user_$yesterday ../../../../stat_4.x/activeUser_store_$yesterday


########
# dispatch vv

#sh dispatchVV.sh $intermediate_result/vv_$yesterday $yesterday 4.11
#sh dispatchVV.sh $intermediate_result/vv_$yesterday $yesterday 4.12
#sh dispatchVVAll.sh $intermediate_result/vv_$yesterday $yesterday 4.12
#sh dispatchVVAll.sh $intermediate_result/vv_$yesterday $yesterday 4.11

#######
# vv uuid
#sh dispatchVVUuid.sh $intermediate_result/vv_uuid_$yesterday $yesterday 4.11
#sh dispatchVVUuid.sh $intermediate_result/vv_uuid_$yesterday $yesterday 4.12

#######
# user detail vv

mv $intermediate_result/vv_user_detail_$yesterday ../../../../user_tracking/


#########
# second part data
#########

second_part_path=../../../../second_part
#########
# pv
#mv $intermediate_result/search_pv_$yesterday $second_part_path/pv/data/pv_$yesterday

########
# continue play
#mv $intermediate_result/continue_play_$yesterday $second_part_path/continuePlay/data
#mv $intermediate_result/simple_continue_play_$yesterday $second_part_path/continuePlay/data

########
# search
#mv $intermediate_result/search_$yesterday $second_part_path/search/data/search_$yesterday
#mv $intermediate_result/pv_$yesterday $second_part_path/search/data/detail_pv_$yesterday

#######
# channelaver
#mv $intermediate_result/mh_$yesterday $second_part_path/mh/data

#######
# ad
#mv $intermediate_result/ad_$yesterday $second_part_path/ad/data

#######
# play hour
#mv $intermediate_result/vv_hour_$yesterday $second_part_path/playHour/data/play_hour_$yesterday

########
# mv dau
#mv $intermediate_result/watch_uv_$yesterday $second_part_path/dau/data

## vim: set ts=2 sw=2: #

