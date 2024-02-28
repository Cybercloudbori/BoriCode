import ipaddress

network = ipaddress.ip_network('172.16.32.0/21')

for ip in network:
    print(ip)
