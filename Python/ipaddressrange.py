import ipaddress

network = ipaddress.ip_network('10.105.130.16/28')

for ip in network:
    print(ip)
