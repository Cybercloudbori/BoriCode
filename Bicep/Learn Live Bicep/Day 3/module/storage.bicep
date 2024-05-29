
param location string = ''
param storagesetting object = {
  name: 'Standard_LRS'
  kind: 'StorageV2'
}

param storageacctname string = ''


resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageacctname
  location: location 
  sku: {
    name: storagesetting.name
  }
  kind: storagesetting.kind
}
