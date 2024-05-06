param location string
param vNetworkName string

resource vNetwork 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vNetworkName
  location: location
  properties: {
    addressSpace: {
addressPrefixes: [
  '10.0.0.0/16']
    }
 subnets: [
  {
    name: 'subnet1'
    properties: {
      addressPrefix: '10.0.0.0/24'
    }
  }
 ] 
  }
}

output vnetGuid string = vNetwork.properties.resourceGuid
