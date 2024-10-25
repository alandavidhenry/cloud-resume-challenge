param location string
param tags object
param functionAppName string
param appServicePlanId string
param storageAccountName string
param cdnEndpointName string
param cosmosDBName string

resource functionApp 'Microsoft.Web/sites@2023-12-01' = {
  name: functionAppName
  location: location
  tags: tags
  kind: 'functionapp,linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlanId
    reserved: true
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.11'
      numberOfWorkers: 1
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 1
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(resourceId('Microsoft.Storage/storageAccounts', storageAccountName), '2023-05-01').keys[0].value}'
        }
        {
          name: 'COSMOS_ENDPOINT'
          value: 'https://${cosmosDBName}.documents.azure.com:443/'
        }
        {
          name: 'COSMOS_KEY'
          value: listKeys(resourceId('Microsoft.DocumentDB/databaseAccounts', cosmosDBName), '2024-05-15').primaryMasterKey
        }
        {
          name: 'DOMAIN_NAME'
          value: 'https://${cdnEndpointName}.azureedge.net'
          // value: 'https://cdne-cloud-resume-challenge.azureedge.net'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(resourceId('Microsoft.Storage/storageAccounts', storageAccountName), '2023-05-01').keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(functionAppName)
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '0'
        }
        {
          name: 'ENABLE_ORYX_BUILD'
          value: 'true'
        }
        {
          name: 'SCM_DO_BUILD_DURING_DEPLOYMENT'
          value: 'true'
        }
        {
          name: 'PYTHON_ENABLE_WORKER_EXTENSIONS'
          value: '1'
        }
      ]
      cors: {
        allowedOrigins: [
          'https://portal.azure.com'
          'https://${cdnEndpointName}.azureedge.net'
          'https://${storageAccountName}.z33.web.${environment().suffixes.storage}'
          // 'https://stcloudresumech.z33.web.core.windows.net'
        ]
        supportCredentials: true
      }
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}
