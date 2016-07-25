############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: test.sh,v 0.0 2016年06月17日 星期五 17时56分57秒  <tangye> Exp $ 
## 
############################################################################
#
###
# # @date   2016年06月17日 星期五 17时56分57秒  
# # @brief 
# #  
# ##
#!/bin/bash
input=$1
day=$2

awk '
BEGIN{FS=OFS="\t"
  str="'$day'""000000";
  if(str>="20160606000000")
    print str; 
}
' $input > t_$day.csv
## vim: set ts=2 sw=2: #

