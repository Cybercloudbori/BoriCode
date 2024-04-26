import ipaddress

def break_ip_pool_into_ranges(ip_pool, subnet_mask):
    network = ipaddress.ip_network(ip_pool)
    subnets = list(network.subnets(new_prefix=subnet_mask))
    return subnets

ip_pool = '172.16.32.0/20'  # The main IP address pool
subnet_mask = 23  # The subnet mask to define the size of the subnets (e.g., /24 for a subnet of size 256)

subnets = break_ip_pool_into_ranges(ip_pool, subnet_mask)

# Print the subnets
for subnet in subnets:
    print(subnet)
