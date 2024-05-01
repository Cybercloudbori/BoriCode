param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@allowed([
  'QA'
  'PROD'
])

param envType string

var appServicePlanName = 'toy-product-launch-plan'
var stgskuname = envType == 'PROD' ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = envType == 'PROD' ? 'P1V3' : 'F1'

resource stgacct 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location 
  sku: {
    name: stgskuname
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}


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

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
