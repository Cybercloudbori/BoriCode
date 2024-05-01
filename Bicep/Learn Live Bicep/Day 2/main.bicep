param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@allowed([
  'QA'
  'PROD'
])

param envType string
var stgskuname = envType == 'PROD' ? 'Standard_GRS' : 'Standard_LRS'


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

module app 'appService.bicep' = {
  name: 'app'
  params: {
    appServiceAppName: appServiceAppName 
    envType: envType
    location: location
  }
}



output appServiceAppHostName string = app.outputs.appServiceAppHostName

