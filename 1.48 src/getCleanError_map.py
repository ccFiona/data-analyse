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
        ip, aver, act, lics, mac, time, sver, net, mf, mod, errorCode, errorMess, 
        serverCode, pt, tpt, vid, ovid,  plid, oplid, lcid, sourceid, streamid, ln, liveid, pt, uuid,
        isdebug
    """

    for line in sys.stdin:
        fields = line.strip("\n").split("\t")
        data = fields[-1]
        data_s, flag = is_json(data)
        if flag and len(fields) >= 2:
          ip = fields[1]
          if "act" in data_s and "bid" in data_s:
            if (data_s["act"] == "error") and (data_s["bid"] == "3.1.3"):
              if "aver" in data_s and (re.match(r'^(4|5)\.\d+\..+\.(200|999)\..*', data_s["aver"])):
                if "lics" in data_s and "did" in data_s and "sver" in data_s\
                  and "time" in data_s and "errorCode" in data_s and "errorMess" in data_s\
                  and "mf" in data_s and "mod" in data_s and "net" in data_s and "isdebug" in data_s:
                    #try:
                    serverCode = data_s["serverCode"] if "serverCode" in data_s else ""
                    pt = data_s["pt"] if "pt" in data_s else ""
                    tpt = data_s["tpt"] if "tpt" in data_s else ""
                    vid = data_s["vid"] if "vid" in data_s else ""
                    ovid = data_s["ovid"] if "ovid" in data_s else ""
                    oplid = data_s["oplid"] if "oplid" in data_s else ""
                    lcid = data_s["lcid"] if "lcid" in data_s else ""
                    plid = data_s["plid"] if "plid" in data_s else ""
                    uuid = data_s["uuid"] if "uuid" in data_s else ""
                    sourceid = data_s["sourceid"] if "sourceid" in data_s else ""
                    streamid = data_s["streamid"] if "streamid" in data_s else ""
                    ln = data_s["ln"] if "ln" in data_s else ""
                    liveid = data_s["liveid"] if "liveid" in data_s else ""
                    
                    ret = data_s["act"] + "\t" + data_s["errorMess"] + "\t" + ln
                    ret = ip + "\t" + data_s["aver"] + "\t" + data_s["act"] + "\t"\
                        + data_s["lics"] + "\t" + data_s["did"] + "\t" + data_s["time"]\
                        + "\t" + data_s["sver"] + "\t" + data_s["net"] + "\t" + data_s["mf"]\
                        + "\t" + data_s["mod"] + "\t" + data_s["errorCode"] + "\t"\
                        + data_s["errorMess"] + "\t" + serverCode + "\t" + pt + "\t" + tpt\
                        + "\t" + vid + "\t" + ovid + "\t" + plid + "\t" + oplid\
                        + "\t" + lcid + "\t" + sourceid + "\t" + streamid + "\t"\
                        + ln + "\t" + liveid  + "\t" + uuid + "\t"\
                        + data_s["isdebug"]

                    print ret.encode("utf-8")
                    #except:
                      #continue

if __name__ == "__main__":
    mapper()

