param location string = resourceGroup().location
param solutionname string = 'bori${uniqueString(resourceGroup().id)}'
param environmentType string = 'prod'
param subnetname string = 'subnet1'
param localadmin string = 'local_admin'
param localpass string = '$ecured@t@>C0st!'
