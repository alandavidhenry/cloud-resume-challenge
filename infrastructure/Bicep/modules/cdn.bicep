param tags object
param cdnProfileName string
param cdnEndpointName string
param storageAccountName string

var location = 'Global'
var storageWebEndpoint = '${storageAccountName}.z33.web.${environment().suffixes.storage}'


resource cdnProfile 'Microsoft.Cdn/profiles@2024-06-01-preview' = {
  name: cdnProfileName
  location: location
  tags: tags
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2024-06-01-preview' = {
  parent: cdnProfile
  name: cdnEndpointName
  location: location
  properties: {
    originHostHeader: storageWebEndpoint
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
          hostName: storageWebEndpoint
          httpPort: 80
          httpsPort: 443
          originHostHeader: storageWebEndpoint
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

output cdneName string = cdnEndpoint.name
