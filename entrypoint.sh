#!/bin/bash

echo "Starting V2Ray..."
/usr/local/bin/v2ray -config /etc/v2ray/config.json &

echo "Starting Nginx..."
nginx -g 'daemon off;'
