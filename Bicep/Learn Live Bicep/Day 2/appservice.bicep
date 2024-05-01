param location string
param appServiceAppName string

@allowed ([
  'PROD'
  'QA'
])

param envType string
var appServicePlanSkuName = (envType == 'PROD') ? 'P2v3' : 'F1'
var appServicePlanName = 'toy-product-launch-prod'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
