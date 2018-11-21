#!/bin/bash

#This will take a backup of the previous days indices
# #The DATE field is used to get the current date - 1 day


DATE=$(date -d "-1 day" +'%Y.%m.%d')


# The syntax for backup is:
# curl -X PUT "{Server Name}:9200/_snapshot/{Backup Repository Name}/{Backup File Name}?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "{Indices to backup}'","ignore_unavailable": true,"include_global_state": false}'

# In the below cases the Repository is named "Backups".
# The Snapshot is named "backup_syslog_{Dated based on the current date - 1 day}
# The indice name is logstash-syslog-{Dated based on the current date - 1 day}


curl -X PUT "localhost:9200/_snapshot/Backups/backup_syslog_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-syslog-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
wait

curl -X PUT "localhost:9200/_snapshot/Backups/backup_bro_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-bro-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
wait

curl -X PUT "localhost:9200/_snapshot/Backups/backup_ossec_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-ossec-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
wait

curl -X PUT "localhost:9200/_snapshot/Backups/backup_ids_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-ids-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
wait

echo curl -X PUT "localhost:9200/_snapshot/Backups/backup_firewall_$DATE?wait_for_completion=true" -H 'Content-Type: application/json' -d '{"indices": "logstash-firewall-'$DATE'","ignore_unavailable": true,"include_global_state": false}'
wait


echo
echo Backup Date $DATE Completed
echo
