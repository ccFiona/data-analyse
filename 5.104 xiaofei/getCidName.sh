############################################################################
mysql -h 10.100.1.70 -u tv_user -p"tv_user1234" -e "use tv;select fstlvl.id,fstlvl.desc from fstlvl;" --default-character-set=utf8 -N > report/code_dict
