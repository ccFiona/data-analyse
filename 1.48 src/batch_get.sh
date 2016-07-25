############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: batch_get.sh,v 0.0 Thu 29 Oct 2015 04:29:04 PM CST  dongjie Exp $ 
## 
############################################################################
#
###
# # @file   batch_get.sh 
# # @author dongjie<dongjie@e.hunantv.com>
# # @date   Thu 29 Oct 2015 04:29:04 PM CST  
# # @brief 
# #  
# ##
#!/bin/bash

## vim: set ts=2 sw=2: #

begin_date=$1
end_date=$2
version=49


if [ $begin_date -gt $end_date ]; then
  echo "begin_date > end_date";
  exit -1;
fi

begindate=`date -d "$1" +%Y%m%d`
enddate=`date -d "$2" +%Y%m%d`

while [ $begindate -lt $enddate ]
do
  echo $begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_view_hour_$version/$begindate"_"$begindate vv_hour_$begindate
  #sort -k1,1 vv_hour_$begindate > tmp
  #mv tmp vv_hour_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_pv_hour_$version/$begindate"_"$begindate pv_hour_$begindate
  #sort -k1,1 pv_hour_$begindate > tmp
  #mv tmp pv_hour_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_activeUser_hour_$version/$begindate"_"$begindate activeUser_hour_$begindate
  #sort -k1,1 activeUser_hour_$begindate > tmp
  #mv tmp activeUser_hour_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_qplay_hour_$version/$begindate"_"$begindate qplay_hour_$begindate
  #sort -k1,1 qplay_hour_$begindate > tmp 
  #mv tmp qplay_hour_$begindate
  hadoop fs -getmerge /data/ott/tangye/ott_view_$version/$begindate"_"$begindate vv_$begindate
  sh add_vv_empty.sh vv_keys vv_$begindate
  sh source_transform.sh keys.txt vv_$begindate vv_t_$begindate.csv vv_title
  hadoop fs -getmerge /data/ott/tangye/ott_view_allvers/$begindate"_"$begindate vv_allvers_$begindate
  sh add_vv_allvers_empty.sh vv_keys vv_allvers_$begindate
  sh source_transform_allvers.sh keys.txt vv_allvers_$begindate vv_allvers_t_$begindate.csv vv_title
  #hadoop fs -getmerge /data/ott/tangye/ott_pv_$version/$begindate"_"$begindate pv_$begindate
  #sh add_pv_empty.sh pv_keys pv_$begindate
  #sh source_transform.sh keys.txt pv_$begindate pv_t_$begindate.csv pv_title
  hadoop fs -getmerge /data/ott/tangye/ott_uuid_view_$version/$begindate"_"$begindate uuid_vv_$begindate
  sh postprocess_play.sh $begindate
  #sh local_uniq_view.sh uuid_vv_$begindate uniq_views_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_activeUser_$version/$begindate"_"$begindate activeUser_$begindate
  sh getActiveNum.sh ../stat_4.x/activeUser_store_$begindate activeUser_$begindate
  hadoop fs -getmerge /data/ott/tangye/ott_gqplay_$version/$begindate"_"$begindate qplay_$begindate
  hadoop fs -getmerge /data/ott/tangye/ott_pv_des_$version/$begindate"_"$begindate pv_des_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_search_$version/$begindate"_"$begindate search_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_table_pv_$version/$begindate"_"$begindate table_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_destination_$version/$begindate"_"$begindate destination_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_error_$version/$begindate"_"$begindate error_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_cidviews_$version/$begindate"_"$begindate cidViews_$begindate
  #sh transCidView.sh cidViews_$begindate cid_key 
  #hadoop fs -getmerge /data/ott/tangye/ott_table_quit_$version/$begindate"_"$begindate table_quit_$begindate
  #hadoop fs -getmerge /data/ott/tangye/ott_view_mac_$version/$begindate"_"$begindate vv_mac_$begindate
  #sh add_vv_empty_mac.sh vv_keys vv_mac_$begindate vv_mac_new_$begindate vv_mac_old_$begindate 
  begindate=`date -d "1 days $begindate" +%Y%m%d`
done
