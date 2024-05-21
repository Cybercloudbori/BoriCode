
using 'main.bicep'

param storagesetting object = {
  name: 'Standard_LRS'
  kind: 'StorageV2'
}
@minLength(3)
@maxLength(24)
param storageacctname string = '${environment}-${location}-stg'
param environment string = 'prod'

param appserviceplanskusettings object = {
  name: 'F1'
  tier: 'Free'
}
param appserviceplanname string = '${environment}-${location}-plan'
param appserviceappname string = '${environment}-${location}-app'
param vnetname string = '${environment}-${location}-vnet'
param pipname string = '${environment}-${location}-pip'
param nicname string = '${environment}-${location}-nic'
param vmname string = '${environment}-${location}-vm'

param vnetaddressspace string = '10.0.0.0/16'
param vnetsubnetaddress string = '10.0.0.0/24'
param subnetname string = 'Subnet1'

param localadmin string = 'local_admin'
param localpass string = '$ecured@t@>C0st!'
param computername string = 'PR-VM-01'
