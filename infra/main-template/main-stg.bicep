// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

targetScope = 'subscription'

// General parameters
@description('Specifies the location for all resources.')
param location string
@allowed([
  'dev'
  'tst'
  'prd'
])
@description('Specifies the environment of the deployment.')
param environment string = 'dev'
@minLength(2)
@maxLength(10)
@description('Specifies the prefix for all resources created in this deployment.')
param prefix string
@description('Specifies the tags that you want to apply to all resources.')
param tags object = {}
@description('Specifies the partner deployment.')
param partner string

// Network parameters
@description('Specifies the address space of the vnet of the mainframe landing zone.')
param vnetAddressPrefix string = '10.1.0.0/16'
@description('Specifies the address space of the subnet that is used for app services of the mainframe landing zone.')
param appServicesSubnetAddressPrefix string = '10.1.0.0/24'
@description('Specifies the address space of the subnet that is used for data services of the mainframe landing zone.')
param dataServicesSubnetAddressPrefix string = '10.1.2.0/24'
@description('Specifies the address space of the subnet that is used for integration services of the mainframe landing zone.')
param dataIntegrationSubnetAddressPrefix string = '10.1.3.0/24'
@description('Specifies the address space of the subnet that is used for external storage services of the mainframe landing zone.')
param externalStorageSubnetAddressPrefix string = '10.1.4.0/24'
@description('Specifies the address space of the subnet that is used for logging services of the mainframe landing zone.')
param loggingServicesSubnetAddressPrefix string = '10.1.5.0/24'
@description('Specifies the resource Id of the vnet in the hub.')
param hubVnetId string = ''
@description('Specifies the private IP address of the central firewall.')
param firewallPrivateIp string = ''
@description('Specifies the public IP address of the central firewall. this is required for AKS')
param firewallPublicIp string = '0.0.0.0'
@description('Specifies the private IP addresses of the dns servers.')
param dnsServerAdresses array = [
  ''
]
// Resource parameters
@description('Specifies the administrator username for the VMs and data services.')
param administratorUsername string = 'SuperMainUser'
@secure()
@description('Specifies the administrator password of the sql servers.')
param administratorPassword string
@description('Specifies the subscription IDs of the other Data Landing Zones.')
param mainframeLandingZoneSubscriptionIds array = []
// Private DNS Zone parameters
@description('Specifies the resource ID of the private DNS zone for Key Vault.')
param privateDnsZoneIdKeyVault string = ''
@description('Specifies the resource ID of the private DNS zone for Data Factory.')
param privateDnsZoneIdDataFactory string = ''
@description('Specifies the resource ID of the private DNS zone for Data Factory Portal.')
param privateDnsZoneIdDataFactoryPortal string = ''
@description('Specifies the resource ID of the private DNS zone for Blob Storage.')
param privateDnsZoneIdBlob string = ''
@description('Specifies the resource ID of the private DNS zone for Azure Sql Server.')
param privateDnsZoneIdSqlServer string = ''
@description('')
param aksuseraccessprincipalId string = ''
@description('')
param aksadminaccessprincipalId string = ''
@description('')
param aksIdentityName string = ''
@description('')
param clusterName string = ''

// Variables

var name = toLower('${prefix}-${environment}')
var guidforgenericaks = (partner == 'genericaks') ? 'PID-6D3E4B5C-C67C-4225-A2ED-17F8F481C8D4' : ''
var guidforraincode = (partner == 'raincode') ? 'PID-965A5A3E-A4EC-4B79-A6B5-E94162B2AC9A' : ''
var guidforstromasys = (partner == 'stromasys') ? 'PID-4C25D08B-B822-488F-BC77-3CC7370C10A8' : ''
var guidfortmaxsoft = (partner == 'tmaxsoft') ? 'PID-46D81167-7F9B-4F38-BEC2-C9EDF4E2485E' : ''
var guidforopentext = (partner == 'opentext') ? 'PID-F037B757-CD90-4C3C-AFC3-8B07D05523C0' : ''
var guidforluminex = (partner == 'luminex') ? 'PID-F8F4E0D7-ADF9-4141-81DD-5911F4093DF7' : ''

var Sysguid = (guidforluminex != '')? guidforluminex :(guidforgenericaks != '')? guidforgenericaks :(guidforopentext != '')? guidforopentext : (guidfortmaxsoft != '')? guidfortmaxsoft : (guidforraincode != '')? guidforraincode : (guidforstromasys != '')? guidforstromasys : 'PID-4241702A-BF95-4B5D-82E7-364BF62FE998'

var tagsDefault = {
  Owner: 'Azure Mainframe Landing Zone'
  Project: 'Azure Mainframe Landing Zone'
  Environment: environment
  Toolkit: 'bicep'
  Name: name
  Sysguid: Sysguid
}
var tagsJoined = union(tagsDefault, tags)
var sqlAdministratorUsername  = administratorUsername
var sqlServer001Name = 'dsvr'
var sqlserverAdminGroupName  = ''
var sqlserverAdminGroupObjectID  = ''


// Application Services resources
resource appServicesResourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: '${name}-appservices'
  location: location
  tags: tagsJoined
  properties: {}
}
module networkServices 'modules/network.bicep' = {
  name: '${Sysguid}-networkServices'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    firewallPrivateIp: firewallPrivateIp
    firewallPublicIp: firewallPublicIp
    dnsServerAdresses: dnsServerAdresses
    vnetAddressPrefix: vnetAddressPrefix
    hubVnetId: hubVnetId
    appServicesSubnetAddressPrefix  : appServicesSubnetAddressPrefix
    dataServicesSubnetAddressPrefix : dataServicesSubnetAddressPrefix
    dataIntegrationSubnetAddressPrefix : dataIntegrationSubnetAddressPrefix
    externalStorageSubnetAddressPrefix : externalStorageSubnetAddressPrefix
    loggingServicesSubnetAddressPrefix : loggingServicesSubnetAddressPrefix
  }
}
module appServicesRaincode './../rehost/raincode/appservices-raincode-linux-metal.bicep' = if (partner == 'raincode') {
  name: '${Sysguid}-appservicesraincode'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    adminUsername: administratorUsername
    adminPassword: administratorPassword
    subnetName: networkServices.outputs.appServicesSubnetName
    vnetName: networkServices.outputs.vnetName
  }
}
module appServicesStromasys './../rehost/stromasys/appservices-stromasys.bicep' = if (partner == 'stromasys') {
  name: '${Sysguid}-appservicesstromasys'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    adminUsername: administratorUsername
    adminPasswordOrKey: administratorPassword
    subnetId: networkServices.outputs.appServicesSubnetId
  }
}

module appServicesOpenframe './../rehost/tmaxsoft/appservices-tmaxsoft-openframe-linux.bicep' = if (partner == 'tmaxsoft') {
  name: '${Sysguid}-appServicesopenframe'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    adminUsername: administratorUsername
    adminPassword: administratorPassword
    subnetName: networkServices.outputs.appServicesSubnetName
    vnetName: networkServices.outputs.vnetName
  }
}
module appServicesOpentext './../rehost/opentxt/appservices-microfocus-es-windows.bicep' = if (partner == 'opentext') {
  name: '${Sysguid}-appServicesopentext'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    adminUsername: administratorUsername
    adminPassword: administratorPassword
    subnetName: networkServices.outputs.appServicesSubnetName
    vnetName: networkServices.outputs.vnetName
  }
}
module appServicesGeneric 'modules/appservices.bicep' = if (partner == 'generic') {
  name: '${Sysguid}-appservicesgeneric'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    adminUsername: administratorUsername
    adminPassword: administratorPassword
    subnetId: networkServices.outputs.appServicesSubnetId
  }
}
//Logging resources
resource loggingResourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: '${name}-logging'
  location: location
  tags: tagsJoined
  properties: {}
}
module loggingServices 'modules/logging.bicep' = {
  name: '${Sysguid}-loggingServices'
  scope: loggingResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    Sysguid: Sysguid
    subnetId: networkServices.outputs.loggingServicesSubnetId
    privateDnsZoneIdKeyVault: privateDnsZoneIdKeyVault
  }
}
module appServicesGenericAks 'modules/appservices-aks.bicep' = if (partner == 'genericaks') {
  name: '${Sysguid}-appservicesaks'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    clusterName: clusterName
    aksIdentityName: aksIdentityName
    rgName: appServicesResourceGroup.name
    aksuseraccessprincipalId: aksuseraccessprincipalId
    aksadminaccessprincipalId:aksadminaccessprincipalId
    acrName: sharedIntegrationServices.outputs.integrationAcrName
    keyvaultName:sharedIntegrationServices.outputs.integrationKeyVaultName
    rtAKSName: networkServices.outputs.routeTableName
    subnetName: networkServices.outputs.appServicesSubnetName
    akslaWorkspaceRGName: loggingResourceGroup.name
    akslaWorkspaceName: loggingServices.outputs.logAnalytics001WorkspaceName
    keyVaultRGName: sharedIntegrationResourceGroup.name
    acrRGName: sharedIntegrationResourceGroup.name
    vnetName:networkServices.outputs.vnetName
  }
}
// Fileshare resources
module fileShareServices 'modules/fileshare.bicep' = {
  name: '${Sysguid}-fileShareServices'
  scope: appServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    subnetId: networkServices.outputs.appServicesSubnetId
    privateDnsZoneIdBlob: privateDnsZoneIdBlob
    fileShareName: 'appfs'
  }
}
// Data resources
resource dataServicesResourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: '${name}-dataservices'
  location: location
  tags: tagsJoined
  properties: {}
}
module dataServices 'modules/dataservices.bicep' = {
  name: '${Sysguid}-dataServices'
  scope: dataServicesResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    subnetId: networkServices.outputs.dataServicesSubnetId
    privateDnsZoneIdBlob: privateDnsZoneIdBlob
    Sysguid: Sysguid
    mainframeLandingZoneSubscriptionIds: mainframeLandingZoneSubscriptionIds
  }
}
module data01 'modules/services/sql.bicep' = {
  name: '${Sysguid}-data01'
  scope: dataServicesResourceGroup
  params: {
    location: location
    tags: tags
    subnetId: networkServices.outputs.dataServicesSubnetId
    administratorUsername: sqlAdministratorUsername
    administratorPassword: administratorPassword
    sqlserverAdminGroupName: sqlserverAdminGroupName
    sqlserverAdminGroupObjectID: sqlserverAdminGroupObjectID
    sqlserverName: sqlServer001Name
    privateDnsZoneIdSqlServer: privateDnsZoneIdSqlServer
  }
}
// External storage resources
resource externalStorageResourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: '${name}-externalstorage'
  location: location
  tags: tagsJoined
  properties: {}
}
module externalStorageServices 'modules/externalstorage.bicep' = {
  name: '${Sysguid}-externalStorageServices'
  scope: externalStorageResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    Sysguid: Sysguid
    subnetId: networkServices.outputs.externalStorageSubnetId
    privateDnsZoneIdBlob: privateDnsZoneIdBlob
    mainframeLandingZoneSubscriptionIds: mainframeLandingZoneSubscriptionIds
  }
}
// Shared integration services
resource sharedIntegrationResourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: '${name}-shared-integration'
  location: location
  tags: tagsJoined
  properties: {}
}
module sharedIntegrationServices 'modules/sharedintegration.bicep' = {
  name: '${Sysguid}-sharedIntServices'
  scope: sharedIntegrationResourceGroup
  params: {
    location: location
    prefix: name
    tags: tagsJoined
    subnetId: networkServices.outputs.dataIntegrationSubnetId
    vnetId: networkServices.outputs.vnetId
    Sysguid: Sysguid
    storageRawId: dataServices.outputs.storageRawId
    storageAccountRawFileSystemId: dataServices.outputs.storageRawFileSystemId
    storageEnrichedCuratedId: dataServices.outputs.storageEnrichedCuratedId
    storageAccountEnrichedCuratedFileSystemId: dataServices.outputs.storageEnrichedCuratedFileSystemId
    privateDnsZoneIdKeyVault: privateDnsZoneIdKeyVault
    privateDnsZoneIdDataFactory: privateDnsZoneIdDataFactory
    privateDnsZoneIdDataFactoryPortal: privateDnsZoneIdDataFactoryPortal
  }
}

// Outputs
output vnetId string = networkServices.outputs.vnetId
output nsgId string = networkServices.outputs.nsgId
output routeTableId string = networkServices.outputs.routeTableId
#disable-next-line outputs-should-not-contain-secrets
// output logAnalyticsWorkspaceKeyVaultId string = loggingServices.outputs.logAnalytics001WorkspaceKeyVaultId
// output logAnalyticsWorkspaceIdSecretName string = loggingServices.outputs.logAnalytics001WorkspaceIdSecretName
// output logAnalyticsWorkspaceKeySecretName string = loggingServices.outputs.logAnalytics001WorkspaceKeySecretName
