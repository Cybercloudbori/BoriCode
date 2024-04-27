param location string = resourceGroup().location

param storageacctname string = 'toylaunch${uniqueString(resourceGroup().id)}'

resource day2storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageacctname
  location: location
  sku: {
    name: 'Standard_LRS'
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
    name: 'F1'
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
