param location string
param tags object
param cosmosDatabaseName string

resource cosmosDatabase 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' = {
  name: cosmosDatabaseName
  location: location
  tags: tags
  properties: {
    databaseAccountOfferType: 'Standard'
    capacity: {
      totalThroughputLimit: 4000
    }
    enableFreeTier: true
    locations: [
      {
        locationName: location 
        failoverPriority: 0 
        isZoneRedundant: false
      }
    ]
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-05-15' = {
  parent: cosmosDatabase
  name: 'ResumeDB'
  properties: {
    resource: {
      id: 'ResumeDB'
    }
  }
}

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  parent: sqlDatabase
  name: 'ResumeContainer'
  properties: {
    resource: {
      id: 'ResumeContainer'
      partitionKey: {
        paths: [
          '/id'
        ]
        kind: 'Hash'
        version: 2
      }
    }
  }
}

output name string = cosmosDatabase.name
