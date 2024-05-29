# Connect to Azure account
#Connect-AzAccount

# Specify the resource group and Azure Firewall Policy name
$resourceGroupName = "westus2"
$firewallPolicyName = "WUS3-Policy-Premium"

try {
    # Get the firewall policy
    $firewallPolicy = Get-AzFirewallPolicy -ResourceGroupName $resourceGroupName -Name $firewallPolicyName -ErrorAction Stop

    # Check if the firewall policy exists
    if ($firewallPolicy) {
        Write-Host "Firewall policy '$firewallPolicyName' retrieved successfully."
        
        # Export rules if any
        if ($firewallPolicy.RuleCollections) {
            $firewallPolicy.RuleCollections.Rules | Export-Csv -Path "C:\temp\Rules.csv" -NoTypeInformation
            Write-Host "Rules exported to CSV successfully."
        } else {
            Write-Host "No rules found in the firewall policy."
        }
    } else {
        Write-Host "Firewall policy '$firewallPolicyName' not found."
    }
} catch {
    Write-Host "Error retrieving firewall policy or exporting rules: $_"
}
