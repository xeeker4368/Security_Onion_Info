I am by no means an expert when it comes to SecurityOnion or Elasticsearch, but these are some notes/commands/scripts I came across during my time implementing Security Onion.

**** Please use at your own risk!  I am not responsible for any damage or data loss that my occur ******


The Template Directory includes templates for:
- Sophos XG Firewalls
- Websense Web Filters
- Forcepoint/CounterAct

The scripts directory includes scripts for backing up and deleting indices.  These is also a script for monitoring the redis queue on the master server.



I also added a file called Emerging_Threat_Rule_Rewrite.
This is a python script that takes the Emerging Threat downloaded.rules file and pulls out any rule with "Poor Reputation IP group" in the message field.

It then creats a rule pass file for all of the inbound/default rules and re-writes them for your HOME_NET to external traffic and HOME_NET to external bi-directional traffic.

My hope in doing this was to cut down on the false positives of external IP's that were just scanning external IP's and captured the more (in my opinion) outbound traffic.
