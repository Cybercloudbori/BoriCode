# Connect to Azure account
Connect-AzAccount -Tenant '72f988bf-86f1-41af-91ab-2d7cd011db47' -SubscriptionId '45a7f642-6aac-4fc2-914b-0b2eeb1c7974'

# Specify the resource group and Azure Firewall Policy name
$resourceGroupName = "WestUS2"
$firewallPolicyName = "WUS3-Policy-Premium"

try {
    # Get the firewall policy
    $firewallPolicy = Get-AzFirewallPolicy -ResourceGroupName $resourceGroupName -Name $firewallPolicyName -ErrorAction Stop

    # Check if the firewall policy exists
    if ($firewallPolicy) {
        Write-Host "Network Rule Collections in Firewall Policy '$firewallPolicyName':"
        # Loop through each network rule collection in the firewall policy
        foreach ($ruleCollection in $firewallPolicy.RuleCollections) {
            Write-Host $ruleCollection.Name
        }
    } else {
        Write-Host "Firewall policy '$firewallPolicyName' not found."
    }
} catch {
    Write-Host "Error retrieving firewall policy '$firewallPolicyName': $_"
}
