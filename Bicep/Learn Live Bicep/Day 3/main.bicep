param location string = resourceGroup().location
param environment string = 'prod'

param adminaccount string = 'local_admin'
var adminpassword = '$ecured@t@>C0st!'
var computername = 'jupagan'


param storagesettings object = {
  name: 'Standard_LRS'
  kind: 'StorageV2'
}

param appplansettings object = {
  skuname: 'F1'
  skutier: 'Free'
}

@minLength(3)
@maxLength(24)
param storagename string = '${environment}${location}stg'

param appserviceplanname string = '${environment}-${location}-plan'
param appserviceappname string = '${environment}-${location}-app'
param vnetname string = '${environment}-${location}-vnet'
param nicname string = '${environment}-${location}-nic'
param pipname string = '${environment}-${location}-pip'
param vmname string = '${environment}-${location}-vm'

@description('Storage Account Resource')
resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storagename
  location: location
  sku: {
    name: storagesettings.name
  }
  kind: storagesettings.kind
}

@description('App Service Plan Resource')
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appserviceplanname
  location: location
  sku: {
    name: appplansettings.skuname
    tier: appplansettings.skutier
  }
}

@description('App Service App Resource')
resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
  name: appserviceappname
  location: location
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlan.id
  }
}

@description('Virtual Network Resource')
resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet1'
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
        }
      }
    ]
  }
}

@description('Public IP Address Resource')
resource pip 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: pipname
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
  }
}

@description('Network Interface Card Resource')
resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: nicname
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
  }
}

@description('Virtual Machine Resource')
resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmname
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_A10'
      }
      osProfile: {
        adminUsername: adminaccount
        adminPassword: adminpassword
        computerName: computername
      }
      networkProfile: {
        networkInterfaces: [
          {
            id: nic.id
          }
        ]
      }
      storageProfile: {
       osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
       }
       imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
       }
    }

  } 
}
