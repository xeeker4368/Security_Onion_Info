#!/bin/bash

#The counter is used to set the first day you want to backup.  In this instance its the Current Date - 7 Days.
counter=7
until [ $counter -gt 21 ]
do

        DATE=$(date -d "-$counter days" +'%Y.%m.%d')

# The syntax for backup is:
# curl -X PUT "{Server Name}:9200/_snapshot/{Backup Repository Name}/{Backup File Name}?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "{Indices to backup}'","ignore_unavailable": true,"include_global_state": false}'

# In the below cases the Repository is named "Backups".
# The Snapshot is named "backup_syslog_{Dated based on the current date - counter}
# The indice name is logstash-syslog-{Dated based on the current date - counter}

        curl -X PUT "localhost:9200/_snapshot/Backups/backup_syslog_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-syslog-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
        wait
	
	curl -X PUT "localhost:9200/_snapshot/Backups/backup_bro_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-bro-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
	wait
	
	curl -X PUT "localhost:9200/_snapshot/Backups/backup_ossec_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-ossec-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
        wait

	curl -X PUT "localhost:9200/_snapshot/Backups/backup_ids_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-ids-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
        wait

	curl -X PUT "localhost:9200/_snapshot/Backups/backup_firewall_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-firewall-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
        wait

        echo Backup Date $DATE
        ((counter++))
#echo $counter

done
echo Completed Backups
