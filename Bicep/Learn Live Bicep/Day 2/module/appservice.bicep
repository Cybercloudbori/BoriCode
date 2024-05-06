param location string
param appServiceAppName string

@allowed ([
  'PROD'
  'ST'
])

param envType string
var appServicePlanName = 'boricua-production-plan'
var appServicePlanSkuName = (envType == 'PROD') ? 'F1' : 'F1'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  } 
}
resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceAppName
  location: location
properties: {
  serverFarmId: appServicePlan.id
  httpsOnly: true
}  
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
