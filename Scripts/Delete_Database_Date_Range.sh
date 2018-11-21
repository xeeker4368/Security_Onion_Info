#/bin/bash


#The counter is used to set the first day you want to backup.  In this instance its the Current Date - 7 Days.
counter=7


#Syntax:
# The synatx to delete indices is curl -X DELETE "{Sever Name}:9200/{Indices Name}"


#This sets the file to stop when the counter is greater than 21.  This would let make the date ranage Current Date - 21 days.
until [ $counter -gt 21 ]
do

        DATE=$(date -d "-$counter days" +'%Y.%m.%d')

        curl -X DELETE "localhost:9200/logstash-syslog-$DATE"
        wait

        curl -X DELETE "localhost:9200/logstash-bro-$DATE"
        wait

        curl -X DELETE "localhost:9200/logstash-ossec-$DATE"
        wait

        curl -X DELETE "localhost:9200/logstash-ids-$DATE"
        wait

        curl -X DELETE "localhost:9200/logstash-firewall-$DATE"
        wait

        echo
        echo Deleted indices for date $DATE
        echo
                ((counter++))

done
echo Databases indices deleted!!

