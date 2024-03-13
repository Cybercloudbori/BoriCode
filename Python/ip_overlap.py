import ipaddress

def check_ip_overlap(ip_ranges):
    ip_networks = [ipaddress.ip_network(ip_range) for ip_range in ip_ranges]
    for i in range(len(ip_networks) - 1):
        for j in range(i + 1, len(ip_networks)):
            if ip_networks[i].overlaps(ip_networks[j]):
                return True  # Overlap detected
    return False  # No overlap found

# Example usage:
ip_ranges = ["172.16.29.0/24", "172.16.0.0/25", "172.16.1.0/24", "172.16.2.0/25", "172.16.3.0/24", "172.16.4.0/26", "172.16.4.64/27","172.16.28.0/24"]
if check_ip_overlap(ip_ranges):
    print("Overlap detected!")
else:
    print("No overlap found.")