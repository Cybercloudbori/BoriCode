param location string = resourceGroup().location
param storageAccountName string = 'boricua${(uniqueString(resourceGroup().id))}'
param appServiceAppName string = 'boricua-app${uniqueString(resourceGroup().id)}'
param vNetworkName string = 'boricua-vnet${uniqueString(resourceGroup().id)}'

@allowed ([
  'PROD'
  'ST'
])

param envType string

module storage 'module/storage.bicep' = {
  name: 'storage'
  params: {
    envType: envType
    location: location
    storageAccountName: storageAccountName 
  }
}

module app 'module/appservice.bicep' = {
  name: 'app'
  params: {
    appServiceAppName: appServiceAppName
    envType: envType
    location: location
  }
}
module vnet 'module/vnet.bicep' = {
  name: 'vnet'
  params: {
    location: location
    vNetworkName: vNetworkName
  }
}

output appServiceAppHostName string = app.outputs.appServiceAppHostName
output vnetGuid string = vnet.outputs.vnetGuid
output storageTier string = storage.outputs.storageTier

