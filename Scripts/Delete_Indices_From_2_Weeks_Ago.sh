#!/bin/bash


#This will delete the indices from a 2 weeks ago
# The DATE field is used to get the current date - 14 day
# In my case I only wanted to keep 14 days of indices live.

#Syntax:
# The synatx to delete indices is curl -X DELETE "{Sever Name}:9200/{Indices Name}"


#This will delete only 1 day of indices based on the date, and in this case {-14 days}

DATE=$(date -d "-14 days" +'%Y.%m.%d')

echo - curl -X DELETE "localhost:9200/logstash-syslog-$DATE"
wait

echo curl -X DELETE "localhost:9200/logstash-bro-$DATE"
wait

echo curl -X DELETE "localhost:9200/logstash-ossec-$DATE"
wait

echo curl -X DELETE "localhost:9200/logstash-ids-$DATE"
wait

echo curl -X DELETE "localhost:9200/logstash-firewall-$DATE"
wait

echo
echo Deleted indices for date $DATE
echo


echo Databases indices deleted!!
