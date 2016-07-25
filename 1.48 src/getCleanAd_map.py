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
        pagename, 
          act=adplay: ad_status, vid, at, aid, ad_num, ad_pre_num, ad_index,
          ad_total_time, ad_start, ad_end
          act=aderror: err, perr, vid, at, aid, param, response, errorMessage, 
          errorDesc, type, cid
        isdebug
    """

    for line in sys.stdin:
        fields = line.strip("\n").split("\t")
        data = fields[-1]
        data_s, flag = is_json(data)
        if flag and len(fields) >= 2:
          ip = fields[1]
          if "act" in data_s and "bid" in data_s:
            if data_s["bid"] == "3.1.10":
              if "aver" in data_s and (re.match(r'^(4|5)\.\d+\..+\.(200|999)\..*', data_s["aver"])):
                if "lics" in data_s and "did" in data_s and "time" in data_s\
                  and "sver" in data_s and "net" in data_s and "mf" in data_s\
                  and "mod" in data_s and "isdebug" in data_s:
                    try:
                      pagename = data_s["pagename"] if "pagename" in data_s else ""

                      ret = ip + "\t" + data_s["aver"] + "\t" + data_s["act"] + "\t"\
                          + data_s["lics"] + "\t" + data_s["did"] + "\t" + data_s["time"]\
                          + "\t" + data_s["sver"] + "\t" + data_s["net"]\
                          + "\t" + data_s["mf"] + "\t" + data_s["mod"] + "\t" + pagename

                      if data_s["act"] == "adplay":
                        ad_status = data_s["ad_status"] if "ad_status" in data_s else ""
                        vid = data_s["vid"] if "vid" in data_s else ""
                        at = data_s["at"] if "at" in data_s else ""
                        aid = data_s["aid"] if "aid" in data_s else ""
                        ad_num = data_s["ad_num"] if "ad_num" in data_s else ""
                        ad_pre_num = data_s["ad_pre_num"] if "ad_pre_num" in data_s else ""
                        ad_index = data_s["ad_index"] if "ad_index" in data_s else ""
                        ad_total_time = data_s["ad_total_time"] if "ad_total_time" in data_s else ""
                        ad_start = data_s["ad_start"] if "ad_start" in data_s else ""
                        ad_end = data_s["ad_end"] if "ad_end" in data_s else ""
                        
                        ret += "\t" + ad_status + "\t" + vid + "\t" + at + "\t" + aid\
                            + "\t" + ad_num + "\t" + ad_pre_num + "\t" + ad_index + "\t"\
                            + ad_total_time + "\t" + ad_start + "\t" + ad_end + "\t" \
                            + data_s["isdebug"]

                        print ret

                      if data_s["act"] == "aderror":
                        err = data_s["err"] if "err" in data_s else ""
                        perr = data_s["perr"] if "perr" in data_s else ""
                        vid = data_s["vid"] if "vid" in data_s else ""
                        at = data_s["at"] if "at" in data_s else ""
                        aid = data_s["aid"] if "aid" in data_s else ""
                        param = data_s["param"] if "param" in data_s else ""
                        response = data_s["response"] if "response" in data_s else ""
                        errorMessage = data_s["errorMessage"] if "errorMessage" in data_s else ""
                        errorDesc = data_s["errorDesc"] if "errorDesc" in data_s else ""
                        type = data_s["type"] if "type" in data_s else ""
                        cid = data_s["cid"] if "cid" in data_s else ""

                        ret += "\t" + err + "\t" + perr + "\t" + vid + "\t" + at + "\t"\
                            + aid + "\t" + param + "\t" + response + "\t" + errorMessage\
                            + "\t" + errorDesc + "\t" + type + "\t" + cid + "\t"\
                            + data_s["isdebug"]

                        print ret

                    except:
                      continue

if __name__ == "__main__":
    mapper()

