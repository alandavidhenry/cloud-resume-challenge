// Create a subscription-level deployment
targetScope = 'subscription'

// Import parameters
@description('Path to the parameters file')
#disable-next-line no-unused-params
param parameterFile string = 'main.bicepparam'

// Reference parameters
param projectName string
param storageAccountPrefix string
param location string
param tags object

// Create unique suffix
var uniqueSuffix = uniqueString(resourceGroupName)

// Name resources
var resourceGroupName = 'rg-${projectName}'
var appServicePlanName = 'asp-${projectName}-${uniqueSuffix}'
var cdnProfileName = 'cdnp-${projectName}-${uniqueSuffix}'
var cdnEndpointName = 'cdne-${projectName}-${uniqueSuffix}'
var cosmosDatabaseName = 'cosno-${projectName}-${uniqueSuffix}'
var functionAppName = 'func-${projectName}-${uniqueSuffix}'
var storageAccountName = 'st${storageAccountPrefix}${uniqueSuffix}'

// Create resource group
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Import resources and pass through parameters
module resources 'resources.bicep' = {
  name: 'resourcesDeployment'
  scope: rg
  params: {
    location: location
    tags: tags
    appServicePlanName: appServicePlanName
    cdnProfileName: cdnProfileName
    cdnEndpointName: cdnEndpointName
    cosmosDatabaseName: cosmosDatabaseName
    functionAppName: functionAppName
    storageAccountName: storageAccountName
  }
}
