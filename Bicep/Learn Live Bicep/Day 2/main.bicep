param location string = resourceGroup().location
param environment string = 'prod'
param solutionname string = 'boricua${uniqueString(resourceGroup().id)}'
param admin string = 'local_admin'
param pass string = '$ecured@t@>C0st!'

param storageskuname  object = {
  name: 'Standard_LRS'
  kind: 'StorageV2'
}

param vmsize object = {
  vmsize: 'Standard_DS1_v2'
}

param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
}

var vnetsubnet = 'subnet1'
var ipname = 'myIPConfig'
var nicname = 'nic1'
var storageaccountname = '${environment}stgacct'
var vnetworkname = '${environment}-${solutionname}-vnet'
var appServicePlanName = '${environment}-${solutionname}-plan'
var appServiceAppName = '${environment}-${solutionname}-app'
var pipname = '${environment}-${solutionname}-pip'
var computername = '${environment}-vm-01'

resource storageacct 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageaccountname
  location: location
  sku: {
    name: storageskuname.name
  }
  kind: storageskuname.kind
}
resource vnetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetworkname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]  
    }
    subnets: [
      {
        name: vnetsubnet
        properties: {
          addressPrefixes: [
          '10.0.0.0/24'
        ]
        }
      }
    ]
  }
}
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku.name
    tier: appServicePlanSku.tier
  }
}
resource appServiceApp 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceAppName
  location: location
  properties: {
    httpsOnly: true
  } 
}
resource PublicIP 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: pipname
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: nicname
  location: location
properties: {
  ipConfigurations: [
    {
      name: ipname
      properties: {
        subnet: {
          id: vnetwork.properties.subnets[0].id
        }
        privateIPAllocationMethod: 'Dynamic'
        publicIPAddress: {
          id: PublicIP.id
        }
      }
    }
  ]
}
}
resource vmachine 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: computername
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmsize.vmsize
    }
    osProfile: {
      adminUsername: admin
      adminPassword: pass
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
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
  } 
}

output storageacctTier string = storageacct.properties.accessTier
output vnetGuid string = vnetwork.properties.resourceGuid
