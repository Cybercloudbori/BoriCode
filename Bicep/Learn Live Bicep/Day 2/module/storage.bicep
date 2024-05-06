
param location string
param storageAccountName string 

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

output storageTier string = storageAccount.properties.accessTier
