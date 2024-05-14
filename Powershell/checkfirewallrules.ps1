# Install Azure PowerShell module if not already installed
# Install-Module -Name Az -AllowClobber -Force

# Connect to Azure account
Connect-AzAccount -Tenant '72f988bf-86f1-41af-91ab-2d7cd011db47' -SubscriptionId 'dc9a7b77-f933-44c7-bf43-3bfb4e16b806'

# Specify the resource group and Azure Firewall name
#$resourceGroupName = "WestUS2"
#$firewallName = "AZFW-LAB-WUS2-FW-02"
#$firewallPolicyName = "WUS2-Policy-Premium"

# Specify the resource group and Azure Firewall Policy names
$resourceGroupName = "CNE-PvtApp-VWAN"
$firewallPolicyNames = @("westus2-hub-001")

# Loop through each firewall policy name
foreach ($firewallPolicyName in $firewallPolicyNames) {
    try {
        # Get the firewall policy
        $firewallPolicy = Get-AzFirewallPolicy -ResourceGroupName $resourceGroupName -Name $firewallPolicyName -ErrorAction Stop

        # Check if the firewall policy exists
        if ($firewallPolicy) {
            $allRulesWithAsterisks = @()

            # Loop through each network rule collection in the firewall policy
            foreach ($ruleCollection in $firewallPolicy.RuleCollections) {
                # Loop through each rule in the network rule collection
                foreach ($rule in $ruleCollection.Rules) {
                    # Check if the rule contains an asterisk
                    if ($rule.Name -like '*[*]*' -or $rule.Source.Addresses -contains '*' -or $rule.Destination.Addresses -contains '*') {
                        $allRulesWithAsterisks += @{
                            "NetworkRuleCollectionName" = $ruleCollection.Name
                            "RuleName" = $rule.Name
                        }
                    }
                }
            }

            # Print the rules containing asterisks
            if ($allRulesWithAsterisks) {
                Write-Host "Rules containing asterisks in Firewall Policy '$($firewallPolicy.Name)':"
                foreach ($rule in $allRulesWithAsterisks) {
                    Write-Host "Network Rule Collection: $($rule.NetworkRuleCollectionName), Rule Name: $($rule.RuleName)"
                }
            } else {
                Write-Host "No rules contain asterisks in Firewall Policy '$($firewallPolicy.Name)'."
            }
        } else {
            Write-Host "Firewall policy '$firewallPolicyName' not found."
        }
    } catch {
        Write-Host "Error retrieving firewall policy '$firewallPolicyName': $_"
    }
}