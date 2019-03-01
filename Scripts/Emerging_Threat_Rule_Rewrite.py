import os
import re

emerging_threat_rule_list = {}
original_sid = re.compile('sid:[0-9]{5,8};')

try:
    os.remove('/home/localadmin/poor_reputation_list.rules')
except OSError:
    pass

try:
    os.remove("/home/localadmin/pass_IP_list.rules")
except OSError:
    pass

try:
    os.remove("/home/localadmin/bidirection_IP_list.rules")
except OSError:
    pass

try:
    os.remove("/home/localadmin/outbound_IP_list.rules")
except OSError:
    pass


emerging_threat_rule_list = open("/etc/nsm/rules/downloaded.rules", "r")
IP_list = open("/home/localadmin/poor_reputation_list.txt", "w")
pass_IP_list = open("/home/localadmin/pass_IP_list.txt", "w")
bidirection_IP_list = open("/home/localadmin/bidirection_IP_list.txt", "w")
outbound_IP_list = open("/home/localadmin/outbound_IP_list.txt", "w")

for threat_rule_lines in emerging_threat_rule_list:
    threat_rule_lines = threat_rule_lines.rstrip('\n')
    if threat_rule_lines.find('Poor Reputation IP group') != -1:
        IP_list.write(threat_rule_lines + "\n")
#        IP_list.write("\n")
#        print(threat_rule_lines)

IP_list = open("/home/localadmin/poor_reputation_list.rules", "r+")
for pass_lines in IP_list:
    pass_lines = pass_lines.replace("alert", "pass")
    pass_lines = pass_lines.replace('msg:"ET CINS Active Threat', 'msg:"CUSTOM PASS - ET CINS Active Threat')
    pass_lines = pass_lines.rstrip('\n')
    pass_IP_list.write(pass_lines)
#    pass_IP_list.write(pass_lines + "\n")
#    pass_IP_list.write(pass_lines + "\n")
    pass_sid = re.search(r"sid:[0-9]{5,8};", pass_lines)
    new_pass_sid = (pass_sid.group())
#    new_sid_length = (len(pass_sid.group()))
    pass_IP_SID_list = pass_lines.replace(new_pass_sid[4:7], "150")
    pass_IP_list.write(pass_lines)
    pass_IP_list.write(pass_IP_SID_list)
    pass_IP_list.write(pass_IP_SID_list + '\n')
#   print(pass_lines)
print("pass_line")

IP_list = open("/home/localadmin/poor_reputation_list.rules", "r+")
for bidirection_IP in IP_list:
    bidirection_IP = bidirection_IP.replace("->", "<>")
    bidirection_IP = bidirection_IP.replace('msg:"ET CINS Active Threat', 'msg:"CUSTOM BIDIRECTIONAL - ET CINS Active Threat')
    bidirection_IP = bidirection_IP.rstrip('\n')
#    bidirection_IP_list.write(bidirection_IP)
#    bidirection_IP_list.write(bidirection_IP +'\n')
    bidirectional_sid = re.search(r"sid:[0-9]{5,8};", bidirection_IP)
    new_bidirectional_sid = (bidirectional_sid.group())
    new_sid_length = (len(bidirectional_sid.group()))
    bidirectional_IP_SID_list = bidirection_IP.replace(new_bidirectional_sid[4:7], "151")
#    print(bidirectional_IP_SID_list)
    bidirection_IP_list.write(bidirectional_IP_SID_list)
    bidirection_IP_list.write(bidirectional_IP_SID_list + '\n')
print("bidirection_IP_list")

IP_list = open("/home/localadmin/poor_reputation_list.rules", "r+")
for outbound_IP in IP_list:
    outbound_IP = outbound_IP.rstrip('\n')
    outbound_IP = outbound_IP.replace("-> $HOME_NET any ", "")
    outbound_IP = outbound_IP.replace("alert ip [", "alert ip $HOME_NET any -> [")
    outbound_IP = outbound_IP.replace('msg:"ET CINS Active Threat', 'msg:"CUSTOM OUTBOUND - ET CINS Active Threat')
    outbound_sid = re.search(r"sid:[0-9]{5,8};", outbound_IP)
    new_outbound_sid = (outbound_sid.group())
    new_sid_length = (len(outbound_sid.group()))
    outbound_IP_SID_list = outbound_IP.replace(new_outbound_sid[4:7], "152")
    outbound_IP_list.write(outbound_IP_SID_list)
    outbound_IP_list.write(outbound_IP_SID_list + '\n')
#    print(bidirection_IP_list)
print("outbound_IP_list")

#pass_IP_list = open("/home/localadmin/pass_IP_list.txt", "r+")
#original_sid = re.compile('sid:[0-9]{5,8};')
#for pass_IP_SID_list in pass_IP_list:
#    pass_sid = re.search(r"sid:[0-9]{5,8};", pass_IP_SID_list)
#    new_pass_sid = (pass_sid.group())
#    new_sid_length = (len(sid.group()))
#    pass_IP_SID_list = pass_IP_SID_list.replace(new_sid[4:7], "100")
#    print(pass_IP_SID_list)




print("complete")
