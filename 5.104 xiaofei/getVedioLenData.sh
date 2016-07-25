#!/bin/bash


#mysql -h 10.100.1.70 -u tv_user -p"tv_user1234" -e "use tv;select sndlvl.id,sndlvl.desc,sndlvl.fstlvl_id,sndlvl.topic,sndlvl.intro,sndlvl.tag,sndlvl.director,sndlvl.player from sndlvl;" --default-character-set=utf8 -N > vid_info

#mysql -h 10.100.1.70 -u tv_user -p"tv_user1234" -e "use tv;select fstlvl.id,fstlvl.desc from fstlvl;" --default-character-set=utf8 -N > code_dict

mysql -h 10.100.1.70 -u tv_user -p"tv_user1234" -e "use tv;select clip.id,clip.sndlvl_id,clip.total_duration,clip.series_count from clip;" --default-character-set=utf8 -N > inputlogs/vid_span
