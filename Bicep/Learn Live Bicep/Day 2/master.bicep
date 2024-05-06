param location string = resourceGroup().location
param storageAccountName string = 'boricua${(uniqueString(resourceGroup().id))}'
param appServiceAppName string = 'boricua-app${uniqueString(resourceGroup().id)}'
param vNetworkName string = 'boricua-vnet${uniqueString(resourceGroup().id)}'

@allowed ([
  'PROD'
  'ST'
])

param envType string
var storageaccountskuname = (envType == 'PROD') ? 'Standard_LRS' : 'Standard_GRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location 
  sku: {
    name: storageaccountskuname
  }
  kind: 'StorageV2'
}
module app 'appservice.bicep' = {
  name: 'app'
  params: {
    appServiceAppName: appServiceAppName
    envType: envType
    location: location
  }
}
module vnet 'vnet.bicep' = {
  name: 'vnet'
  params: {
    location: location
    vNetworkName: vNetworkName
  }
}

output appServiceAppHostName string = app.outputs.appServiceAppHostName
output vnetGuid string = vnet.outputs.vnetGuid


