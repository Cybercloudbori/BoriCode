# Get the Azure Firewall Policy
$policy = Get-AzFirewallPolicy -Name "EA-Policy-Premium" -ResourceGroupName "WestUS2"

# Iterate through the rule collection groups
foreach ($ruleCollectionGroup in $policy.RuleCollectionGroups) {
    # Iterate through the rules in each rule collection
    foreach ($rule in $ruleCollectionGroup.Rules) {
        # Check if the rule name contains an asterisk
        if ($rule.Name -like "*`*") {
            Write-Host "Rule with an asterisk: $($rule.Name)"
        }
    }
}

