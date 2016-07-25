#!/usr/bin/env python
#-*-coding: utf-8-*-

"""
This module get simple vv
Author: tangye(tangyel@126.com)
"""

import sys
import os
import re
import ConfigParser
import traceback
import urllib2
import string
import json
import datetime


def is_json(myjson):
  try:
    if len(myjson) >= 2 and myjson[0] == "{" and myjson[-1] == "}":
      json_obj = json.loads(myjson)
    else:
      return ({}, False)
  except ValueError, e:
    return ({}, False)
  return (json_obj, True)

def parse_time(t):
    try:
      dt = datetime.datetime.strptime(t, "%Y%m%d%H%M%S")
      dt = dt.replace(second=dt.second / 5 * 5)
      return (dt, True)
    except ValueError, e:
      return (e, False)

def mapper():
    """
    Returns:
        ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts, 
        playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
        isdebug
    """

    for line in sys.stdin:
        fields = line.strip("\n").split("\t")
        data = fields[-1]
        data_s, flag = is_json(data)
        if flag and len(fields) >= 2:
          ip = fields[1]
          if "act" in data_s and "bid" in data_s:
            if ((data_s["act"] == "play" and "ct" in data_s) or (data_s["act"] == "stop" and\
              "td" in data_s) or (data_s["act"] == "pplay")) and (data_s["bid"] == "3.1.1"):
              if "aver" in data_s and (re.match(r'^(4|5)\.\d+\..+\.(200|999)\..*', data_s["aver"])):
                if "lics" in data_s and "oplid" in data_s and "ovid" in data_s\
                  and "time" in data_s and "did" in data_s and "sver" in data_s\
                  and "mf" in data_s and "mod" in data_s and "net" in data_s and "vid" in data_s\
                  and "playsrc" in data_s and "def" in data_s and "isdebug" in data_s and \
                  "istry" in data_s and "pay" in data_s and "suuid" in data_s:
                    try:
                      cid = data_s["cid"] if "cid" in data_s else ""
                      vts = data_s["vts"] if "vts" in data_s else ""
                      pagename = data_s["pagename"] if "pagename" in data_s else ""
                      sovid = data_s["sovid"] if "sovid" in data_s else ""
                      idx = data_s["idx"] if "idx" in data_s else ""
                      ref = data_s["ref"] if "ref" in data_s else ""
                      ap = data_s["ap"] if "ap" in data_s else ""
                      plid = data_s["plid"] if "plid" in data_s else ""
                      pt = data_s["pt"] if "pt" in data_s else ""
                      uuid = data_s["uuid"] if "uuid" in data_s else ""
                      cf = data_s["cf"] if "cf" in data_s else ""
                      ct = data_s["ct"] if "ct" in data_s else ""
                      td = data_s["td"] if "td" in data_s else ""
                      vts = data_s["vts"] if "vts" in data_s else ""
                      
                      
                      ret = ip + "\t" + data_s["aver"] + "\t" + data_s["act"] + "\t"\
                          + data_s["lics"] + "\t" + data_s["did"] + "\t" + data_s["time"]\
                          + "\t" + data_s["sver"] + "\t" + data_s["net"]\
                          + "\t" + data_s["suuid"] + "\t" + cid + "\t" + data_s["oplid"]\
                          + "\t" + data_s["ovid"] + "\t" + ct\
                          + "\t" + td + "\t" + vts + "\t" + data_s["playsrc"]\
                          + "\t" + pagename + "\t" + data_s["mf"] + "\t"\
                          + data_s["pay"] + "\t" + data_s["def"] + "\t" + sovid + "\t"\
                          + data_s["vid"] + "\t" + idx + "\t" + data_s["mod"] + "\t" + ref + "\t"\
                          + ap + "\t" + plid + "\t" + pt + "\t" + uuid + "\t"\
                          + cf + "\t" + data_s["istry"] + "\t" + data_s["isdebug"]

                      print ret
                    except:
                      continue

if __name__ == "__main__":
    mapper()

