#!/bin/sh
cd ~ && /sbin/iptables-save > ./iptables.rules
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -F
/sbin/iptables -A INPUT -p tcp --dport 22 -s 10.128.$3.0/24 -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dport 3306 -s 10.128.$1.0/24 -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dport 3306 -s 10.128.$2.0/24 -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dport 3306 -s 10.128.$3.0/24 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A INPUT -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -N LOGGING
/sbin/iptables -A INPUT -j LOGGING
/sbin/iptables -A LOGGING -m limit --limit 5/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
/sbin/iptables -A LOGGING -j DROP