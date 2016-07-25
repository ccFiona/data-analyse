#!/usr/bin/env python
# -*-coding:utf-8-*-
############################################################################
## 
## Copyright (c) 2013 hunantv.com, Inc. All Rights Reserved
## $Id: ottContinuePlayTrigger.py,v 0.0 2016年03月22日 星期二 17时15分22秒  <> Exp $ 
## 
############################################################################
#
###
# # @file   ottContinuePlayTrigger.py 
# # @author <tangye><<tangye@mgtv.com>>
# # @date   2016年03月22日 星期二 17时15分22秒  
# # @brief 
# #  
# ##

"""
algo:
  1. put together vv pattern each user
  2. sort according time
  3. search the 1st I5
  4. the item before 1st I5
"""

import sys
from datetime import time, datetime


def parse_time(t):
  try:
    date_t = datetime.strptime(t, "%Y%m%d%H%M%S")
    return (date_t, True)
  except Exception,e:
    return (e, False)


def read(vvlog):
  ######
  # inputs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
  # playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
  # isdebug

  user_data_dict = {} #{lics:[time, playsrc, plid, cid]}
  with open(vvlog) as vv_in:
    for line in vv_in:
      fields = line.strip("\n").strip("\t").split("\t")
      if len(fields) >= 32:
	act = fields[2]
	lics = fields[3]
	time = fields[5] # 20160322160000
	playsrc = fields[15]
	plid = fields[26]
	cid = fields[9]
	if cid == "":
	  cid = "other"
	if act == "play":
	  if not (lics == "" or time == "" or playsrc == "" or plid == ""):
	    date_t, flag = parse_time(time)
	    if flag:
	      if not lics in user_data_dict:
		user_data_dict[lics] = []
	      user_data_dict[lics].append((time, playsrc, plid, cid))
  
  # sorting
  for key, value in user_data_dict.items():
    sorted_user_pattern = sorted(value, key=lambda x:x[0])
    user_data_dict[key] = sorted_user_pattern

  return user_data_dict


def find_continue_trigger(user_data_dict):
  """
  search 
  two pointer
  """
  plid_dict = {} #{plid:[trigger_count, trigger_user_num]}
  cid_dict = {} #{cid:[trigger_count, trigger_user_num]}
  for lics, watch_list in user_data_dict.items():
    pre_pos = 0
    pos = 0
    if len(watch_list) > 1:
      pos += 1
      while pos < len(watch_list):
	pre_items = watch_list[pre_pos]
	curr_items = watch_list[pos]
	pre_playsrc = pre_items[1]
	curr_playsrc = curr_items[1]
	pre_plid = pre_items[2]
	curr_plid = curr_items[2]
	pre_cid = pre_items[3]
	curr_cid = curr_items[3]

	if not (pre_playsrc == "I5") and (curr_playsrc == "I5"):
	  if not pre_plid == curr_plid:
	    if not pre_plid in plid_dict:
	      plid_dict[pre_plid] = [0, set()]
	    plid_dict[pre_plid][0] += 1
	    plid_dict[pre_plid][1].add(lics)

	    if not pre_cid in cid_dict:
	      cid_dict[pre_cid] = [0, set()]
	    cid_dict[pre_cid][0] += 1
	    cid_dict[pre_cid][1].add(lics)

	pre_pos += 1
	pos += 1


  
  return (plid_dict, cid_dict)


def write(out, plid_dict, cid_dict):

  with open(out, 'w') as o:
    for plid, value in plid_dict.items():
      ratio = float(value[0]/len(value[1])) if len(value[1]) > 0 else 0
      ret = "2\t" + plid + "\t" + str(value[0]) + "\t" + str(len(value[1])) + "\t" + str(ratio)
      o.write(ret+"\n")

    for cid, value in cid_dict.items():
      ratio = float(value[0]/len(value[1])) if len(value[1]) > 0 else 0
      ret = "7\t" + cid + "\t" + str(value[0]) + "\t" + str(len(value[1])) + "\t" + str(ratio)
      o.write(ret+"\n")
    


if __name__ == '__main__':
  vvlog = sys.argv[1]
  out = sys.argv[2]
  user_data_dict = read(vvlog)
  plid_dict, cid_dict = find_continue_trigger(user_data_dict)
  write(out, plid_dict, cid_dict)
## vim: set ts=2 sw=2: #

