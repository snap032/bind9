#!/bin/bash

sudo apt-get install bind9 -y

#Генерируем ключ
dnssec-keygen -a HMAC-MD5 -b 128 -r /dev/urandom -n USER DHCP_UPDATER
#Выводим в консоль ключ
cat Kdhcp_updater.*.private|grep Key
#Делаем переменую
key=${cat Kdhcp_updater.*.private|grep Key}
sudo tee -a /etc/resolvconf/resolv.conf.d/tail << EOF

domain first_name.net
search nameDevOps.org
nameserver 127.0.0.1

domain first_name.net
search nameDevOps.org
nameserver 127.0.0.1
EOF


mkdir /etc/rndc.key/
git clone https://github.com/snap032/bind9.git
cp bind9/rndc.conf /etc/rndc.key/
cp bind9/named.conf /etc/rndc.key/
cp bind9/named.conf.options /etc/bind/named.conf.options
cp bind9/prime_zone /var/lib/bind/prime_zone
cp bind9/reverse_zone /var/lib/bind/reverse_zone
cp bind9/named.conf.local /etc/bind/named.conf.local


sudo cp /etc/bind/db.local /var/lib/bind/prime_zone





