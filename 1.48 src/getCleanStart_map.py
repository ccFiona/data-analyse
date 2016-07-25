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
        ip, aver, act, lics, mac, time, sver, net
        pagename, mf, mod, uuid
        isdebug
    """

    for line in sys.stdin:
        fields = line.strip("\n").split("\t")
        data = fields[-1]
        data_s, flag = is_json(data)
        if flag and len(fields) >= 2:
          ip = fields[1]
          if "act" in data_s and "bid" in data_s:
            if data_s["bid"] == "3.4.0":
              if "aver" in data_s and (re.match(r'^(4|5)\.\d+\..+\.(200|999)\..*', data_s["aver"])):
                if "lics" in data_s and "time" in data_s and "did" in data_s and "sver" in data_s\
                    and "net" in data_s and "isdebug" in data_s:
                    try:
                      mf = data_s["mf"] if "mf" in data_s else ""
                      mod = data_s["mod"] if "mod" in data_s else ""
                      pagename = data_s["pagename"] if "pagename" in data_s else ""
                      uuid = data_s["uuid"] if "uuid" in data_s else ""
                      
                      
                      ret = ip + "\t" + data_s["aver"] + "\t" + data_s["act"] + "\t"\
                          + data_s["lics"] + "\t" + data_s["did"] + "\t" + data_s["time"]\
                          + "\t" + data_s["sver"] + "\t" + data_s["net"] + "\t" + pagename\
                          + "\t" + mf + "\t" + mod + "\t" + uuid + "\t" + data_s["isdebug"]\

                      print ret
                    except:
                      continue

if __name__ == "__main__":
    mapper()

