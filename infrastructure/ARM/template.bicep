param sites_func_cloud_resume_challenge_name string = 'func-cloud-resume-challenge'
param storageAccounts_stcloudresumech_name string = 'stcloudresumech'
param profiles_cdnp_cloud_resume_challenge_name string = 'cdnp-cloud-resume-challenge'
param serverfarms_ASP_rgcloudresumechallenge_84ba_name string = 'ASP-rgcloudresumechallenge-84ba'
param databaseAccounts_cosno_cloud_resume_challenge_name string = 'cosno-cloud-resume-challenge'

resource profiles_cdnp_cloud_resume_challenge_name_resource 'Microsoft.Cdn/profiles@2024-06-01-preview' = {
  name: profiles_cdnp_cloud_resume_challenge_name
  location: 'Global'
  sku: {
    name: 'Standard_Microsoft'
  }
  kind: 'cdn'
  properties: {}
}

resource databaseAccounts_cosno_cloud_resume_challenge_name_resource 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' = {
  name: databaseAccounts_cosno_cloud_resume_challenge_name
  location: 'UK South'
  tags: {
    defaultExperience: 'Core (SQL)'
    project: 'cloud-resume-challenge'
    'hidden-cosmos-mmspecial': ''
  }
  kind: 'GlobalDocumentDB'
  identity: {
    type: 'None'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    disableKeyBasedMetadataWriteAccess: false
    enableFreeTier: false
    enableAnalyticalStorage: false
    analyticalStorageConfiguration: {
      schemaType: 'WellDefined'
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    networkAclBypass: 'None'
    disableLocalAuth: false
    enablePartitionMerge: false
    enableBurstCapacity: false
    minimalTlsVersion: 'Tls12'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    locations: [
      {
        locationName: 'UK South'
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    cors: []
    capabilities: []
    ipRules: []
    backupPolicy: {
      type: 'Periodic'
      periodicModeProperties: {
        backupIntervalInMinutes: 240
        backupRetentionIntervalInHours: 8
        backupStorageRedundancy: 'Geo'
      }
    }
    networkAclBypassResourceIds: []
    capacity: {
      totalThroughputLimit: 4000
    }
  }
}

resource storageAccounts_stcloudresumech_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_stcloudresumech_name
  location: 'uksouth'
  tags: {
    project: 'cloud-resume-challenge'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource serverfarms_ASP_rgcloudresumechallenge_84ba_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: serverfarms_ASP_rgcloudresumechallenge_84ba_name
  location: 'UK South'
  tags: {
    project: 'cloud-resume-challenge'
  }
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource profiles_cdnp_cloud_resume_challenge_name_cdne_cloud_resume_challenge 'Microsoft.Cdn/profiles/endpoints@2024-06-01-preview' = {
  parent: profiles_cdnp_cloud_resume_challenge_name_resource
  name: 'cdne-cloud-resume-challenge'
  location: 'Global'
  properties: {
    originHostHeader: 'stcloudresumech.z33.web.core.windows.net'
    contentTypesToCompress: [
      'application/eot'
      'application/font'
      'application/font-sfnt'
      'application/javascript'
      'application/json'
      'application/opentype'
      'application/otf'
      'application/pkcs7-mime'
      'application/truetype'
      'application/ttf'
      'application/vnd.ms-fontobject'
      'application/xhtml+xml'
      'application/xml'
      'application/xml+rss'
      'application/x-font-opentype'
      'application/x-font-truetype'
      'application/x-font-ttf'
      'application/x-httpd-cgi'
      'application/x-javascript'
      'application/x-mpegurl'
      'application/x-opentype'
      'application/x-otf'
      'application/x-perl'
      'application/x-ttf'
      'font/eot'
      'font/ttf'
      'font/otf'
      'font/opentype'
      'image/svg+xml'
      'text/css'
      'text/csv'
      'text/html'
      'text/javascript'
      'text/js'
      'text/plain'
      'text/richtext'
      'text/tab-separated-values'
      'text/xml'
      'text/x-script'
      'text/x-component'
      'text/x-java-source'
    ]
    isCompressionEnabled: true
    isHttpAllowed: true
    isHttpsAllowed: true
    queryStringCachingBehavior: 'BypassCaching'
    origins: [
      {
        name: 'default-origin-22a1c789'
        properties: {
          hostName: 'stcloudresumech.z33.web.core.windows.net'
          httpPort: 80
          httpsPort: 443
          originHostHeader: 'stcloudresumech.z33.web.core.windows.net'
          priority: 1
          weight: 1000
          enabled: true
        }
      }
    ]
    originGroups: []
    geoFilters: []
  }
}

resource databaseAccounts_cosno_cloud_resume_challenge_name_ResumeDB 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-05-15' = {
  parent: databaseAccounts_cosno_cloud_resume_challenge_name_resource
  name: 'ResumeDB'
  properties: {
    resource: {
      id: 'ResumeDB'
    }
  }
}

resource databaseAccounts_cosno_cloud_resume_challenge_name_00000000_0000_0000_0000_000000000001 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2024-05-15' = {
  parent: databaseAccounts_cosno_cloud_resume_challenge_name_resource
  name: '00000000-0000-0000-0000-000000000001'
  properties: {
    roleName: 'Cosmos DB Built-in Data Reader'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_cosno_cloud_resume_challenge_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read'
        ]
        notDataActions: []
      }
    ]
  }
}

resource databaseAccounts_cosno_cloud_resume_challenge_name_00000000_0000_0000_0000_000000000002 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2024-05-15' = {
  parent: databaseAccounts_cosno_cloud_resume_challenge_name_resource
  name: '00000000-0000-0000-0000-000000000002'
  properties: {
    roleName: 'Cosmos DB Built-in Data Contributor'
    type: 'BuiltInRole'
    assignableScopes: [
      databaseAccounts_cosno_cloud_resume_challenge_name_resource.id
    ]
    permissions: [
      {
        dataActions: [
          'Microsoft.DocumentDB/databaseAccounts/readMetadata'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*'
          'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
        ]
        notDataActions: []
      }
    ]
  }
}

resource storageAccounts_stcloudresumech_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stcloudresumech_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_stcloudresumech_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stcloudresumech_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_func_cloud_resume_challenge_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_func_cloud_resume_challenge_name
  location: 'UK South'
  tags: {
    project: 'cloud-resume-challenge'
  }
  kind: 'functionapp,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_func_cloud_resume_challenge_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_func_cloud_resume_challenge_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_rgcloudresumechallenge_84ba_name_resource.id
    reserved: true
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'PYTHON|3.11'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '482E121B69BFFE705F3EA93CD00DE46CC02BDB3B9E95D8EFCF0E682AF0BAEDB0'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_func_cloud_resume_challenge_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: 'ftp'
  location: 'UK South'
  tags: {
    project: 'cloud-resume-challenge'
  }
  properties: {
    allow: false
  }
}

resource sites_func_cloud_resume_challenge_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: 'scm'
  location: 'UK South'
  tags: {
    project: 'cloud-resume-challenge'
  }
  properties: {
    allow: true
  }
}

resource sites_func_cloud_resume_challenge_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: 'web'
  location: 'UK South'
  tags: {
    project: 'cloud-resume-challenge'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'PYTHON|3.11'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2022'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$func-cloud-resume-challenge'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
        'https://cdne-cloud-resume-challenge.azureedge.net'
        'https://stcloudresumech.z33.web.core.windows.net'
      ]
      supportCredentials: true
    }
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_func_cloud_resume_challenge_name_4b7b9901_786b_4878_86a8_9a94779dd80e 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: '4b7b9901-786b-4878-86a8-9a94779dd80e'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'GITHUB_ZIP_DEPLOY_FUNCTIONS_V1'
    message: '{"type":"deployment","sha":"1b7a0934d7b2b3e25e423ec5d81a86b9d235513c","repoName":"alandavidhenry/cloud-resume-challenge","actor":"alandavidhenry","slotName":"production"}'
    start_time: '2024-10-23T13:55:36.7707925Z'
    end_time: '2024-10-23T13:55:51.7322276Z'
    active: false
  }
}

resource sites_func_cloud_resume_challenge_name_b7c7ec6d_bf5c_46c1_a6cb_3dd794e4746c 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: 'b7c7ec6d-bf5c-46c1-a6cb-3dd794e4746c'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'GITHUB_ZIP_DEPLOY_FUNCTIONS_V1'
    message: '{"type":"deployment","sha":"3570305dfd8771d4588831d64ba0a2659a4a8ee3","repoName":"alandavidhenry/cloud-resume-challenge","actor":"alandavidhenry","slotName":"production"}'
    start_time: '2024-10-23T15:41:18.8629439Z'
    end_time: '2024-10-23T15:41:27.2047855Z'
    active: true
  }
}

resource sites_func_cloud_resume_challenge_name_d5a630c7_acee_49f9_b694_a7e67df91638 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: 'd5a630c7-acee-49f9-b694-a7e67df91638'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'GITHUB_ZIP_DEPLOY_FUNCTIONS_V1'
    message: '{"type":"deployment","sha":"fe6aebcc7af09adcfc9f2f96236ca9896fbb88df","repoName":"alandavidhenry/cloud-resume-challenge","actor":"alandavidhenry","slotName":"production"}'
    start_time: '2024-10-23T15:20:17.0516345Z'
    end_time: '2024-10-23T15:20:25.286162Z'
    active: false
  }
}

resource sites_func_cloud_resume_challenge_name_http_trigger 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: 'http_trigger'
  location: 'UK South'
  properties: {
    script_href: 'https://func-cloud-resume-challenge.azurewebsites.net/admin/vfs/home/site/wwwroot/function_app.py'
    test_data_href: 'https://func-cloud-resume-challenge.azurewebsites.net/admin/vfs/tmp/FunctionsData/http_trigger.dat'
    href: 'https://func-cloud-resume-challenge.azurewebsites.net/admin/functions/http_trigger'
    config: {
      name: 'http_trigger'
      entryPoint: 'http_trigger'
      scriptFile: 'function_app.py'
      language: 'python'
      functionDirectory: '/home/site/wwwroot'
      bindings: [
        {
          direction: 'IN'
          type: 'httpTrigger'
          name: 'req'
          authLevel: 'FUNCTION'
          route: 'http_trigger'
        }
        {
          direction: 'OUT'
          type: 'http'
          name: '$return'
        }
      ]
    }
    invoke_url_template: 'https://func-cloud-resume-challenge.azurewebsites.net/api/http_trigger'
    language: 'python'
    isDisabled: false
  }
}

resource sites_func_cloud_resume_challenge_name_sites_func_cloud_resume_challenge_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_func_cloud_resume_challenge_name_resource
  name: '${sites_func_cloud_resume_challenge_name}.azurewebsites.net'
  location: 'UK South'
  properties: {
    siteName: 'func-cloud-resume-challenge'
    hostNameType: 'Verified'
  }
}

resource profiles_cdnp_cloud_resume_challenge_name_cdne_cloud_resume_challenge_default_origin_22a1c789 'Microsoft.Cdn/profiles/endpoints/origins@2024-06-01-preview' = {
  parent: profiles_cdnp_cloud_resume_challenge_name_cdne_cloud_resume_challenge
  name: 'default-origin-22a1c789'
  properties: {
    hostName: 'stcloudresumech.z33.web.core.windows.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: 'stcloudresumech.z33.web.core.windows.net'
    priority: 1
    weight: 1000
    enabled: true
  }
  dependsOn: [
    profiles_cdnp_cloud_resume_challenge_name_resource
  ]
}

resource databaseAccounts_cosno_cloud_resume_challenge_name_ResumeDB_ResumeContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2024-05-15' = {
  parent: databaseAccounts_cosno_cloud_resume_challenge_name_ResumeDB
  name: 'ResumeContainer'
  properties: {
    resource: {
      id: 'ResumeContainer'
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/"_etag"/?'
          }
        ]
      }
      partitionKey: {
        paths: [
          '/id'
        ]
        kind: 'Hash'
        version: 2
      }
      uniqueKeyPolicy: {
        uniqueKeys: []
      }
      conflictResolutionPolicy: {
        mode: 'LastWriterWins'
        conflictResolutionPath: '/_ts'
      }
      computedProperties: []
    }
  }
  dependsOn: [
    databaseAccounts_cosno_cloud_resume_challenge_name_resource
  ]
}

resource storageAccounts_stcloudresumech_name_default_web 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_default
  name: '$web'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stcloudresumech_name_resource
  ]
}

resource storageAccounts_stcloudresumech_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stcloudresumech_name_resource
  ]
}

resource storageAccounts_stcloudresumech_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stcloudresumech_name_resource
  ]
}

resource storageAccounts_stcloudresumech_name_default_function_releases 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_default
  name: 'function-releases'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stcloudresumech_name_resource
  ]
}

resource storageAccounts_stcloudresumech_name_default_scm_releases 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_stcloudresumech_name_default
  name: 'scm-releases'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stcloudresumech_name_resource
  ]
}

resource storageAccounts_stcloudresumech_name_default_func_cloud_resume_challenge8a71 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stcloudresumech_name_default
  name: 'func-cloud-resume-challenge8a71'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_stcloudresumech_name_resource
  ]
}

resource storageAccounts_stcloudresumech_name_default_AzureFunctionsDiagnosticEvents202410 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stcloudresumech_name_default
  name: 'AzureFunctionsDiagnosticEvents202410'
  properties: {}
  dependsOn: [
    storageAccounts_stcloudresumech_name_resource
  ]
}

resource databaseAccounts_cosno_cloud_resume_challenge_name_ResumeDB_ResumeContainer_default 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/throughputSettings@2024-05-15' = {
  parent: databaseAccounts_cosno_cloud_resume_challenge_name_ResumeDB_ResumeContainer
  name: 'default'
  properties: {
    resource: {
      throughput: 100
      autoscaleSettings: {
        maxThroughput: 1000
      }
    }
  }
  dependsOn: [
    databaseAccounts_cosno_cloud_resume_challenge_name_ResumeDB
    databaseAccounts_cosno_cloud_resume_challenge_name_resource
  ]
}
