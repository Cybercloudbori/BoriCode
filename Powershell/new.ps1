# Install Azure PowerShell module if not already installed
# Install-Module -Name Az -AllowClobber -Force

# Connect to Azure account
#Connect-AzAccount
#Set-AzContext -Subscription "45a7f642-6aac-4fc2-914b-0b2eeb1c7974"
Connect-AzAccount -Tenant '72f988bf-86f1-41af-91ab-2d7cd011db47' -SubscriptionId 'dc9a7b77-f933-44c7-bf43-3bfb4e16b806'

# Specify the resource group and Azure Firewall Policy name
$resourceGroupName = "CNE-PvtApp-VWAN"
$firewallPolicyName = "westus2-hub-001"

try {
    # Get the firewall policy
    $firewallPolicy = Get-AzFirewallPolicy -ResourceGroupName $resourceGroupName -Name $firewallPolicyName -ErrorAction Stop

    # Check if the firewall policy exists
    if ($firewallPolicy) {
        Write-Host "Checking for rules with asterisks (*) in Firewall Policy '$firewallPolicyName':"

        # Flag to track if any rule with asterisks is found
        $asteriskFound = $false

        # Loop through each network rule collection in the firewall policy
        foreach ($ruleCollection in $firewallPolicy.RuleCollections) {
            # Loop through each rule in the network rule collection
            foreach ($rule in $ruleCollection.Rules) {
                # Check if the rule contains an asterisk in any of its fields
                if ($rule.Name -like '*[*]*' -or $rule.Source.Addresses -contains '*' -or $rule.Destination.Addresses -contains '*') {
                    Write-Host "Rule with asterisks found in Network Rule Collection '$($ruleCollection.Name)': $($rule.Name)"
                    $asteriskFound = $true
                }
            }
        }

        # Check if any rule with asterisks was found
        if (-not $asteriskFound) {
            Write-Host "No rules with asterisks found in Firewall Policy '$firewallPolicyName'."
        }
    } else {
        Write-Host "Firewall policy '$firewallPolicyName' not found."
    }
} catch {
    Write-Host "Error retrieving firewall policy '$firewallPolicyName': $_"
}
