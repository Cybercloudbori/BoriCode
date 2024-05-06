
param location string = resourceGroup().location
param storageAccountName string = 'toylaunch${(uniqueString(resourceGroup().id))}'

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


