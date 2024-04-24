resource day2storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'cybercloudstorageacct'
  location: 'eastus2'
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
  location: 'eastus2'
  sku: {
    name: 'F1'
  }
  }
  resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
    name: 'toy-product-web-app'
    location: 'eastus2'
    properties: {
      serverFarmId: appServicePlan.id
      httpsOnly: true
    }
  }
