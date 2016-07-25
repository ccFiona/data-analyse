#!/bin/bash


begin_date=$1
end_date=$2

HADOOP_HOME="/usr/lib/hadoop/"


if [ $begin_date -gt $end_date ]; then
  echo "begin_date > end_date";
  exit -1;
fi

function extractDateList(){
  begindate=`date -d "$1" +%Y%m%d`
  enddate=`date -d "$2" +%Y%m%d`
  result=${begindate}
  while [ $begindate -lt $enddate ]
  do
    begindate=`date -d "1 days $begindate" +%Y%m%d`
    result=$result","$begindate
  done
  echo -n $result
}

echo $begin_date
echo $end_date

date_list=`extractDateList $begin_date $end_date`


input1=/data/logs/bid-3.1.11-default/{$date_list}/*/*
echo $input
output_path=/data/ott/tangye/clean_search
output=$output_path"/"$begin_date"_"$end_date


${HADOOP_HOME}/bin/hadoop fs -rmr $output
${HADOOP_HOME}/bin/hadoop jar ${HADOOP_HOME}/hadoop-streaming.jar \
  -D mapred.job.name="get_clean_search_tangye" \
  -D stream.num.map.output.key.fields=3 \
  -D num.key.fields.for.partition=1 \
  -D mapred.reduce.tasks=1 \
  -input "$input1" \
  -output "$output" \
  -mapper "python getCleanSearch_map.py" \
  -reducer "cat" \
  -file "getCleanSearch_map.py" \
  -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner
echo "step02 done."

