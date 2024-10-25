// Reference parameters
param location string
param tags object
param appServicePlanName string
param cdnProfileName string
param cdnEndpointName string
param cosmosDatabaseName string
param functionAppName string
param storageAccountName string

module appServicePlan 'modules/appServicePlan.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    tags: tags
  }
}

module cdn 'modules/cdn.bicep' = {
  name: 'cdn'
  params: {
    cdnProfileName: cdnProfileName
    cdnEndpointName: cdnEndpointName
    storageAccountName: storageAccount.outputs.name
    tags: tags
  }
}

module cosmosDatabase 'modules/cosmosDatabase.bicep' = {
  name: cosmosDatabaseName
  params: {
    cosmosDatabaseName: cosmosDatabaseName
    location: location
    tags: tags
  }
}

module functionApp 'modules/functionApp.bicep' = {
  name: 'functionAppDeployment'
  params: {
    functionAppName: functionAppName
    location: location
    tags: tags
    appServicePlanId: appServicePlan.outputs.id
    cdnEndpointName: cdn.outputs.cdneName
    storageAccountName: storageAccount.outputs.name
    cosmosDBName: cosmosDatabase.outputs.name
  }
}

module storageAccount 'modules/storageAccount.bicep' = {
  name: 'storageAccountDeployment'
  params: {
    storageAccountName: storageAccountName
    location: location
    tags: tags
  }
}
