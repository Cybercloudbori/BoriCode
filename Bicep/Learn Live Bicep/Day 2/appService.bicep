param location string
param appServiceAppName string

@allowed([
  'QA'
  'PROD'
])

param envType string

var appServicePlanName = 'toy-product-launch-plan'
var appServicePlanSkuName = envType == 'PROD' ? 'P1V3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-03-01' = {
  name: appServiceAppName
  location: location
  properties: { 
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output  appServiceAppHostName string = appServiceApp.properties.defaultHostName
