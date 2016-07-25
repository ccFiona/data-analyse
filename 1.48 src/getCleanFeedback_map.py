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


def mapper():
    """
    Returns:
        reqid, aver, region, lics, orcdata, did,
        sourceid, time, recommend_label(0-show, 1-click), ohitid(-1-show)
    """

    for line in sys.stdin:
        fields = line.strip("\n").split("\t")
        data = fields[-1]
        data_s, flag = is_json(data)
        if flag:
          if "act" in data_s and "bid" in data_s:
            if (data_s["act"] == "recommend_show" or (data_s["act"] == "recommend" and "ohitid" in\
              data_s)) and (data_s["bid"] == "3.2.0"):
              if "aver" in data_s and re.match(r'^4\.(9|10|11)\..+\.200\..*', data_s["aver"]):
                if "region" in data_s and "lics" in data_s and "orcdata" in data_s\
                  and "reqid" in data_s and "did" in data_s and ("isdebug" in data_s and\
                      data_s["isdebug"] == "0") and "time" in data_s:
                    try:
                      ret = data_s["reqid"] + "\t" + data_s["aver"] + "\t" + data_s["region"] + "\t"\
                          + data_s["lics"] + "\t" + data_s["orcdata"] + "\t" + data_s["did"] + "\t"\
                          + "-1" + "\t" + data_s["time"]
                      if data_s["act"] == "recommend_show":
                        ret += "0" + "\t" + "-1"
                      if data_s["act"] == "recommend":
                        ret += "1" + "\t" + data_s["ohitid"]
                      print ret
                    except:
                      continue

if __name__ == "__main__":
    mapper()

