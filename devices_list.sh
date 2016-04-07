#!/bin/sh
data=''
current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
for ip in $(cat /proc/net/arp | grep -v IP|grep -v 0x0| awk '{print $1}'); do
    client=$(grep $ip /tmp/dhcp.leases |awk '{print $1","$2","$3","$4}')
    if [ -z $client ]; then
        data=$data"_ZV_"$timeStamp","$(cat /proc/net/arp|grep $ip|awk '{print $4}')","$ip",unknow"
    else
        data=$data"_ZV_"$client
    fi
done
echo $data
curl 'http://host/router/data?key=hifiwifi_001&data='$data
