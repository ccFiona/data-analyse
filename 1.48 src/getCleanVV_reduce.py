#!/usr/bin/env python
#-*-coding: utf-8-*-

"""
This module stats pcweb data

Author: tangye(tangyel@126.com)
"""


import sys
import os
import datetime




def reducer():
    """
    Returns:
        aver, cid, setid(oplid), vid(ovid), lics, mac, videotime, watchtime, time
    """
    curr_aver = None
    aver = None
    curr_cid = None
    cid = None
    curr_oplid = None
    oplid = None
    curr_ovid = None
    ovid = None
    curr_lics = None
    lics = None
    curr_mac = None
    mac = None
    curr_vts = None
    vts = None
    local_act_dict = {}


    for line in sys.stdin:
      fields = line.strip("\n").strip("\t").split("\t")
      if len(fields) == 10:
        aver = fields[0]
        cid = fields[1]
        oplid = fields[2]
        ovid = fields[3]
        lics = fields[4]
        mac = fields[5]
        vts = fields[6]
        act = fields[7]
        watchtime = int(fields[8])
        minutes = fields[9]
          
        if curr_aver == aver and curr_cid == cid and curr_oplid == oplid and curr_ovid == ovid and curr_lics == lics and curr_mac == mac and curr_vts == vts:
          key = act
          if not key in local_act_dict or watchtime > local_act_dict[key][0]:
            local_act_dict[key] = (watchtime, minutes) 
        else:
          if curr_aver and curr_cid and curr_oplid and curr_ovid and curr_lics and curr_mac and curr_vts:
            ret = curr_aver + "\t" + curr_cid +"\t" + curr_oplid + "\t" + curr_ovid + "\t" + curr_lics + "\t" + curr_mac + "\t" + curr_vts
            if "stop" in local_act_dict:
              ret += "\t" + str(local_act_dict["stop"][0]) + "\t" + local_act_dict["stop"][1]
              print ret
            elif "play" in local_act_dict:
              ret += "\t" + str(local_act_dict["play"][0]) + "\t" + local_act_dict["play"][1]
              print ret

          local_act_dict.clear()
          curr_aver = aver
          curr_cid = cid
          curr_oplid = oplid
          curr_ovid = ovid
          curr_lics = lics
          curr_mac = mac
          curr_vts = vts
          key = act
          if not key in local_act_dict or watchtime > local_act_dict[key][0]:
            local_act_dict[key] = (watchtime, minutes) 
        
    if curr_aver == aver and curr_cid == cid and curr_oplid == oplid and curr_ovid == ovid and\
      curr_lics == lics and curr_mac == mac and curr_vts == vts and curr_aver:
      ret = curr_aver + "\t" + curr_cid +"\t" + curr_oplid + "\t" + curr_ovid + "\t" + curr_lics + "\t" + curr_mac + "\t" + curr_vts
      if "stop" in local_act_dict:
        ret += "\t" + str(local_act_dict["stop"][0]) + "\t" + local_act_dict["stop"][1]
        print ret
      elif "play" in local_act_dict:
        ret += "\t" + str(local_act_dict["play"][0]) + "\t" + local_act_dict["play"][1]
        print ret
    

if __name__ == "__main__":
    reducer()
