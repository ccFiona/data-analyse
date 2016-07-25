############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: tmp.sh,v 0.0 2016年06月28日 星期二 20时50分32秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @file   tmp.sh 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年06月28日 星期二 20时50分32秒  
# # @brief 
# #  
# ##
#!/bin/bash

cp playLenReport/playLenReport.csv /data/dev/tangye/ott/daily_report/playLenReport.csv

#awk 'BEGIN{FS=OFS="\t"}
#{
#  ll[$3]=1;
#  av[$2]++;
#  lics[$2"\t"$4]=1;
#  u[$4]=1;
#}
#END{
#for(c in lics){
#  split(c,a,"\t");
#  uv[a[1]]++;
#}
#for(l in av){
#  print l,av[l],uv[l],length(u);
#}
#}' report/vv_tmp_20160617 |sort -k2nr
## vim: set ts=2 sw=2: #

