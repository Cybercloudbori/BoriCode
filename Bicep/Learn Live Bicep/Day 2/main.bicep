param location string = resourceGroup().location
param storageAccountName string = 'toylaunch$(uniqueString(resourceGroup().id)'
param appServicePlanName string = 'toylaunchplan$(uniqueString(resourceGroup().id)'
param appServicePlanSkuName string = 'toylaunchplansku$(uniqueString(resourceGroup().id)'
param appServiceAppName string = 'toylaunchappname$(uniqueString(resourceGroup().id)'

@allowed([
  'QA'
  'PROD'
])

param envTyoe string

var stgskuname = envTyoe == 'QA' ? 'Standard_LRS' : 'Standard_GRS'
var stgacctkind = envTyoe == 'QA' ? 'Storage' : 'StorageV2'

resource stgacct 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location 
  sku: {
    name: stgskuname 
  }
  kind: stgacctkind
  properties: {
    accessTier: 'Hot'
  }
}


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
