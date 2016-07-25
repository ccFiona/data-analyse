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

def parse_searchinfo(s):
    try:
      fields = s.strip("\t").strip("\n").split("&")
      if len(fields) > 0:
        for item in fields:
          items = item.strip("\t").strip("\n").split("=")
          if len(items) == 2:
            if items[0] == "videoid":
              return (items[1], True)
    except ValueError, e:
      return (e, False)

def mapper():
    """
    Returns:
      aver, lics, type(0-search keyword, 1-search to pv), searchinfo
    """

    for line in sys.stdin:
        fields = line.strip("\n").split("\t")
        data = fields[-1]
        data_s, flag = is_json(data)
        if flag:
          if "act" in data_s and "bid" in data_s and data_s["bid"] == "3.1.11":
            if "aver" in data_s and re.match(r'^4\.(9|10|11)\..+\.200\..*', data_s["aver"]):
              if "pagename" in data_s and "lics" in data_s and "did" in data_s:
                if data_s["act"] == "dataload" and data_s["pagename"] == "D" and "ext1" in data_s\
                    and data_s["ext1"] == "0" and "ext5" in data_s:
                    try:
                      ret = data_s["aver"] + "\t" + data_s["lics"] + "\t" + "0" + "\t" +\
                        data_s["ext5"]
                      print ret
                    except:
                      continue
                if data_s["act"] == "pageload" and data_s["pagename"] == "C" and "ext2" in data_s\
                    and data_s["ext2"] == "D" and "ext8" in data_s:
                      try:
                        searchinfo, flag = parse_searchinfo(data_s["ext8"])
                        if flag:
                          ret = data_s["aver"] + "\t" + data_s["lics"] + "\t" + "1" + "\t" + \
                              searchinfo
                          print ret
                      except:
                        continue


if __name__ == "__main__":
    mapper()

