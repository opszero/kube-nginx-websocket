#!/bin/bash

sed -i "s/SOCKET_SERVER/${SOCKET_SERVER}/g" /etc/nginx/nginx.conf
sed -i "s/FULL_CERT/${FULL_CERT}/g" /etc/nginx/nginx.conf
sed -i "s/PRIVATE_KEY/${PRIVATE_KEY}/g" /etc/nginx/nginx.conf

nginx
