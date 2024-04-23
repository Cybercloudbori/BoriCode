//Parameters:
@description('Definition of all hubs to be created')
param hub object

@description('Resource prefix used for all created Azure objects')
param serviceLine string = 'FACNET'

@description('Definition of the hub being deployed')
param vHubDefinition object

@description('Azure Resource Tag values to be applied')
param tagValues object

@description('Auth Key for the circuit')
param authKey string = '943e4b82-6966-484e-8ab3-35d3ed19f3e6'

@description('Peering Id that will be used for the connection')
param peeringId string

//Variables:
@description('Pull in region names and abbreviations')
var regionLookup = json(loadTextContent('regions.json'))

//Resources:
resource expressroutegateway 'Microsoft.Network/expressRouteGateways@2023-05-01' = {
  name: toUpper('${serviceLine}-${regionLookup[hub.location].prefix}-ER-GW-${vHubDefinition.instanceId}')
  location: hub.location
  tags: tagValues
  properties: {
    virtualHub: {
      id: hub.id
    }
    autoScaleConfiguration: {
      bounds: {
        min: vHubDefinition.erGwScaleUnits
      }
    }
    expressRouteConnections: !empty(authKey) ? [
      {
        name: '${hub.name}-ER-CONN-${vHubDefinition.instanceId}'
        properties: {
          authorizationKey: authKey
          expressRouteCircuitPeering: {
            id: peeringId
          }
        }
      }
    ] : []
  }
}

output authKey string = authKey
output peeringId string = peeringId

output id string = expressroutegateway.id
output name string = expressroutegateway.name
/*
output circuitName string = circuit.name
output circuitId string = circuit.id
output peeringName string = peering.name
output peeringId string = peering.id
*/
