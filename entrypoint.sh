#!/bin/sh
cd /app

# start rubyprotocol api
nohup ./owner-api > owner-api.log 2>&1 &
nohup ./authority-api > authority-api.log 2>&1 &
nohup ./purchaser-api > purchaser-api.log 2>&1 &

# start zeropool node
./zeropool-substrate-node $*