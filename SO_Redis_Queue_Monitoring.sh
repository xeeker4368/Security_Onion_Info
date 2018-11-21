#!/bin/bash


#This is output the Redis Queue every 30 seconds 15 times.


/usr/bin/redis-cli -r 15 -i 30 llen logstash:redis
