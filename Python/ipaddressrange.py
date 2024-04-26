import ipaddress

network = ipaddress.ip_network('172.16.0.0/20')

for ip in network:
    print(ip)
