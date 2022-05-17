#!/usr/bin/env bash

ip_excluded()
{
    ip=$1
    exclude=(0.0.0.0 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 *.*)
    [[ " ${exclude[*]} " =~ " ${ip} " ]] && echo "true" || echo "false"
}

get_subnet()
{
    subnet=""
    f=0
    for i in $(echo $1 | tr "." "\n")
        do
            if [ $f -lt "3" ]; then
                    subnet=${subnet}"."${i}
            fi
            let "f=f+1"
    done
    echo ${subnet:1}
}

check_suspicious_connections()
{
    if [ -f "/tmp/compromised_ip_full.txt" ]; then
        last_update=`date -r /tmp/compromised_ip_full.txt '+%j'`
        current_time=`date '+%j'`
        let ddiff="$current_time-$last_update"
        if [ $ddiff -gt 2 ]; then
            echo "Download compromised ip list"
            `curl https://zonefiles.io/f/compromised/ip/full/ > /tmp/compromised_ip_full.txt`
            `curl https://zonefiles.io/f/compromised/ip/live/ > /tmp/compromised_ip_live.txt`
            `curl https://ftp.ripe.net/pub/stats/ripencc/delegated-ripencc-latest > /tmp/delegated-ripencc-latest.txt`
        fi
    else
        echo "Download compromised ip list"
        `curl https://zonefiles.io/f/compromised/ip/full/ > /tmp/compromised_ip_full.txt`
        `curl https://zonefiles.io/f/compromised/ip/live/ > /tmp/compromised_ip_live.txt`
        `curl https://ftp.ripe.net/pub/stats/ripencc/delegated-ripencc-latest > /tmp/delegated-ripencc-latest.txt`
    fi
    
    echo "Start connection check"
    # OSX
    #for i in `netstat -na | egrep 'LISTEN|ESTABLISH' | egrep tcp4 | awk '{print $5}' | cut -d "."  -f "1,2,3,4"`
    #Linux
    for i in `netstat --inet -pan | egrep 'LISTEN|ESTABLISH' | awk '{print $5}' | cut -d ":"  -f "1"`    
    	do
		if [ $(ip_excluded ${i}) = "true" ]; then
                continue
            else
                a=`grep ${i} /tmp/compromised_ip_live.txt`
                b=`grep ${i} /tmp/compromised_ip_full.txt`
                subnet=$(get_subnet ${i})
                c=`grep ${subnet} /tmp/delegated-ripencc-latest.txt`
                if [ "${#a}" -gt 0 ] | [ "${#b}" -gt 0 ] | [ "${#c}" -gt 0 ]; then
                    echo "Compromised IP >>" ${i}
                    #OSX
                    #sudo ipfw add deny src-ip ${i}; ipfw add deny dst-ip ${i}
                    #Linux
                    su -c "/usr/sbin/ufw deny from ${i} to any"
		    # su -c "/usr/sbin/iptables -I INPUT -s ${i} -j DROP"
		fi
            fi
    done
    echo "Connection check finished."
}
