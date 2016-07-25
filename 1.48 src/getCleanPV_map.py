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
        ip, aver, act, lics, mac, time, sver, net, mf, mod,
        pagename, ext1 ~ ext10
        isdebug
    """

    for line in sys.stdin:
        fields = line.strip("\n").split("\t")
        data = fields[-1]
        data_s, flag = is_json(data)
        if flag and len(fields) >= 2:
          ip = fields[1]
          if "act" in data_s and "bid" in data_s:
            if data_s["bid"] == "3.1.11":
              if "aver" in data_s and (re.match(r'^(4|5)\.\d+\..+\.(200|999)\..*', data_s["aver"])):
                if "lics" in data_s and "did" in data_s and "time" in data_s\
                  and "sver" in data_s and "net" in data_s and "mf" in data_s\
                  and "mod" in data_s and "isdebug" in data_s:
                    try:
                      pagename = data_s["pagename"] if "pagename" in data_s else ""
                      ext1 = data_s["ext1"] if "ext1" in data_s else ""
                      ext2 = data_s["ext2"] if "ext2" in data_s else ""
                      ext3 = data_s["ext3"] if "ext3" in data_s else ""
                      ext4 = data_s["ext4"] if "ext4" in data_s else ""
                      ext5 = data_s["ext5"].encode("utf-8") if "ext5" in data_s else ""
                      ext6 = data_s["ext6"] if "ext6" in data_s else ""
                      ext7 = data_s["ext7"] if "ext7" in data_s else ""
                      ext8 = data_s["ext8"] if "ext8" in data_s else ""
                      ext9 = data_s["ext9"] if "ext9" in data_s else ""
                      ext10 = data_s["ext10"] if "ext10" in data_s else ""
                      
                      ret = ip + "\t" + data_s["aver"] + "\t" + data_s["act"] + "\t"\
                          + data_s["lics"] + "\t" + data_s["did"] + "\t" + data_s["time"]\
                          + "\t" + data_s["sver"] + "\t" + data_s["net"]\
                          + "\t" + data_s["mf"] + "\t" + data_s["mod"] + "\t" + pagename\
                          + "\t" + ext1 + "\t" + ext2 + "\t" + ext3 + "\t" + ext4 + "\t"\
                          + ext5 + "\t" + ext6 + "\t" + ext7 + "\t" + ext8 + "\t" + ext9\
                          + "\t" + ext10 + "\t" + data_s["isdebug"]

                      print ret
                    except:
                      continue

if __name__ == "__main__":
    mapper()

