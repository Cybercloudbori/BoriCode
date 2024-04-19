import ipaddress

network = ipaddress.ip_network('172.16.32.0/20')

for ip in network:
    print(ip)
