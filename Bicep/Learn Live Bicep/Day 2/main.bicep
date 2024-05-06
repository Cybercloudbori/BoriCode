
param location string = resourceGroup().location
param storageAccountName string = 'boricua${(uniqueString(resourceGroup().id))}'
param appServiceAppName string = 'boricua-app${uniqueString(resourceGroup().id)}'

@allowed ([
  'PROD'
  'ST'
])

param envType string
var appServicePlanName = 'boricua-production-plan'
var storageaccountskuname = (envType == 'PROD') ? 'Standard_LRS' : 'Standard_GRS'


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location 
  sku: {
    name: storageaccountskuname
  }
  kind: 'StorageV2'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  } 
}

resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceAppName
  location: location
properties: {
  serverFarmId: appServicePlan.id
}  
}


