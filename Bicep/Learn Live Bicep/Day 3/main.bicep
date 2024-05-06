param location string = resourceGroup().location
param env string = 'dev'
param uniquesolution string = 'toy${uniqueString(resourceGroup().id)}'
param appServicePlanInstanceCount int = 1

var appServicePlanName = '${env}-${uniquesolution}-plan'
var appServiceAppName = '${env}-${uniquesolution}-app'
param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku.name
    tier: appServicePlanSku.tier
    capacity: appServicePlanInstanceCount
  }  
}

resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceAppName
  location: location
  properties: {
    httpsOnly: true
  } 
}




