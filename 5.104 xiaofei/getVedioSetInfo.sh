############################################################################
mysql -h 10.100.1.70 -u tv_user -p"tv_user1234" -e "use tv;select sndlvl.id,sndlvl.desc,sndlvl.fstlvl_id,sndlvl.topic,sndlvl.intro,GROUP_CONCAT(tag.name) as vtag,sndlvl.director,sndlvl.player from sndlvl,sndlvl_tag,tag where sndlvl.id=sndlvl_tag.sndlvl_id and sndlvl_tag.tag_id=tag.id group by sndlvl.id;" --default-character-set=utf8 -N > report/vid_info