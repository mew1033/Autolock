#! /bin/bash

echo -n "Input the ports you want to allow (ie: 22,21,5000:5500): "
read ports
iptables -t nat -I PREROUTING -p tcp -m tcp --match multiport --dports $ports -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 1:65535 -j REDIRECT --to-ports 4444
