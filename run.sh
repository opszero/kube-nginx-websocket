#!/bin/bash

erb /etc/nginx/nginx.conf.erb > /etc/nginx/nginx.conf

cat /etc/nginx/nginx.conf

nginx
