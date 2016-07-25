#!/bin/bash

input=$1
out=$2
vvplaylogs=$3

echo $input
echo $out
echo $path

#####
# inputs:ip, aver, act, lics, mac, time, sver, net, suuid, cid, setid(oplid), vid(ovid), ct, td, vts,
# playsrc, pagename, mf, pay, def, sovid, vid, idx, mod, ref, ap, plid, pt, uuid, cf, istry,
# isdebug
# 
# Returens: mac

awk 'BEGIN{FS=OFS="\t";}
{
    act=$3;
    pt=$28;
    ap=$26;

    if(pt==""){pt="null"}
    if(ap==""){ap="0"}

  if((NF>=32)&&(act=="play")&&(pt=="0")||(pt=="3")){
    print $0 > "'$vvplaylogs'";
    aver=$2;
    mac=$5;

    if(aver=="5.0.1.999.2.TY.0.0_Release"){
      user[mac]++;
    }
  }
}
END{for(u in user){
print u,user[u];}
}' $input > $out

