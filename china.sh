#!/bin/bash

ZIP="GeoIPCountryCSV.zip"
URL="http://geolite.maxmind.com/download/geoip/database/GeoIPCountryCSV.zip"
DIR="/home/etc/fw"
DATA="/usr/etc/geoip/GeoIPCountryWhois.csv"

mkdir -p $DIR
cd $DIR
wget $URL
unzip $ZIP


for IPRANGE in `egrep "CN" $DATA | cut -d, -f1,2 | sed -e 's/"//g' | sed -e 's/,/-/g'`
do
    echo $IPRANGE
    iptables -A INPUT -p all -m iprange --src-range $IPRANGE -j DROP
done
