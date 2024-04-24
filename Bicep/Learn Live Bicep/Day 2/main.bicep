resource day2storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'cybercloudstorageacct'
  location: 'westus3'
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
  location: 'westus3'
  sku: {
    name: 'F1'
  }
  }
  resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
    name: 'toy-product-web-app'
    location: 'westus3'
    properties: {
      serverFarmId: appServicePlan.id
      httpsOnly: true
    }
  }
