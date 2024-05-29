import ipaddress

network = ipaddress.ip_network('172.20.248.0/23')

for ip in network:
    print(ip)
