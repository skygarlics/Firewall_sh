#!/bin/bash

iptables -N blacklist
iptables -N ssh
iptables -A INPUT -m state --state NEW -p tcp --dport ssh -j ssh
iptables -A blacklist -m recent --set --name blacklist
iptables -A blacklist -j REJECT
iptables -A ssh -m recent --update --seconds 600 --hitcount 1 --name blacklist -j REJECT
iptables -A ssh -m recent --set --name ssh
iptables -A ssh -m recent --update --seconds 20 --hitcount 5 --name ssh -j blacklist
iptables -A ssh -j ACCEPT