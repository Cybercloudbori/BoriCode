param location string = resourceGroup().location
param storageacctname string = 'toylaunch${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param enviromentType string
var storageaccountskuname = (enviromentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appserviceplanskuname = (enviromentType == 'prod') ? 'P2v3' : 'F1'

resource day2storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageacctname
  location: location
  sku: {
    name: storageaccountskuname
  }
  kind: 'StorageV2'
properties:{
  accessTier: 'Hot'
}
}
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'toy-product-launch-plan-starter'
  location: location
  sku: {
    name: appserviceplanskuname
  }
  }
  resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
    name: 'toy-product-web-app'
    location: location
    properties: {
      serverFarmId: appServicePlan.id
      httpsOnly: true
    }
  }


  