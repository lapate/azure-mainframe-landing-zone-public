# Azure Landing Zone Acclerator for Modernized Mainframe and Midrange workloads - Prerequisites

This template repository contains all templates to deploy the Azure Landing Zone for Modernized Mainframe and Midrange workloads. The Azure Landing Zone Accelerator for Modernized Mainframe and Midrange workloads is a logical construct that enables data retention and execution of data workloads for generating insights and value with data.

## What will be deployed?

By navigating through the deployment steps, you will deploy the following setup in a subscription:

> **Note:** Before deploying the resources, we recommend to check registration status of the required resource providers in your subscription. For more information, see [Resource providers for Azure services](https://docs.microsoft.com/azure/azure-resource-manager/management/resource-providers-and-types).

<!-- ( ![Mainframe Landing Zone](/docs/images/mainframeLandingZone.png) -->

The deployment and code artifacts include the following services:

- [Virtual Network](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview)
- [Network Security Groups](https://docs.microsoft.com/azure/virtual-network/network-security-groups-overview)
- [Route Tables](https://docs.microsoft.com/azure/virtual-network/virtual-networks-udr-overview)
- [Key Vault](https://docs.microsoft.com/azure/key-vault/general)
- [Storage Account](https://docs.microsoft.com/azure/storage/common/storage-account-overview)
- [Data Lake Storage Gen2](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-introduction)
- [Log Analytics](https://docs.microsoft.com/azure/azure-monitor/learn/quick-create-workspace)
- [SQL Database](https://docs.microsoft.com/azure/azure-sql/database/)

## Code Structure

To help you more quickly understand the structure of the repository, here is an overview of what the respective folders contain:

| File/folder                   | Description                                |
| ----------------------------- | ------------------------------------------ |
| `code`                        | Sample password generation script that will be run in the deployment workflow for resources that require a password during the deployment. |
| `docs`                        | Resources for this README.                 |
| `infra`                       | Folder containing all the ARM and Bicep templates for each of the resources that will be deployed. |
| `CODE_OF_CONDUCT.md`          | Microsoft Open Source Code of Conduct.     |
| `LICENSE`                     | The license for the sample.                |
| `README.md`                   | This README file.                          |
| `SECURITY.md`                 | Microsoft Security README.                 |

## Prerequisites



**Before we start with the deployment, please make sure that you have the following available:**

- An Azure subscription. If you don't have an Azure subscription, [create your Azure free account today](https://azure.microsoft.com/free/).
- [User Access Administrator](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#user-access-administrator) or [Owner](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#owner) or [Contributor](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles#contributor) access to the subscription to be able to create a service principal and role assignments for it.

- A **Azure Core Landing Zone** deployed. For more information, check the [Azure Core Landing Zone](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md)  repository.

    Ensure you have an Azure Core Landing Zone in place:

    | Reference implementation   | Deploy to Azure |
    |:---------------------------|:----------------|
    |[Azure Core Landing Zone](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://aka.ms/caf/ready/accelerator)|

> **Note:** Please make sure you have successfully deployed a [Azure Core Landing Zone](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md). The Azure Landing Zone for Modernized Mainframe and Midrange workloads relies on the Private DNS Zones that are deployed in the core landing zone. If you have Private DNS Zones deployed elsewhere, you can also point to these. If you do not have the Private DNS Zones deployed for the respective services, this template deployment will fail. Please ensure the Azure Core Landing Zone hub resource group contains DNS zone as below picture

![Hub Resource Group](/docs/images/HubResourcegroup.png)

If you are deploying generic containers solution, please ensure the hub resource group also contains the centralized Azure Firewall, associated firewall network policy to allow for outgoing internet traffic via public ip. The setup should like below

![Hub Resource Group](/docs/images/HubResourcegroup-aks.png)

Firewall Policy

![Hub Resource Group](/docs/images/HubResourcegroup-aks-fwpolicy.png)

- Also, this accelerator uses certified Azure Marketplace images to provision partner specific virtual machines. Please ensure before running the automation, that the accept terms for those images are accepted by running below commands

    **az vm image accept-terms --urn <published:offer:sku:version>**

    e.g. az vm image accept-terms --urn

| Reference implementation   | URN |
|:---------------------------|:----------------|
|Raincode Metal Linux Solution|raincode:raincode_metal_linux:raincode_metal_linux:4.2.197|
|Stromasys Solution|stromasys:charon-ssp-ve:charon-ssp-with-ve-license:latest|
|Opentext Solution|micro-focus:es-vm:es-vm:8.0.5|
|Tmaxsoft Solution|tmaxsoft1608612658335:openframvm:ofvm001:0.0.1|
|Tidal Solution|tidal-migrations:tidal_tools:tidal_tools:latest|

- For the deployment, please choose one of the **Supported Regions**.

## Supported Regions

For now, we are recommending to select one of the regions mentioned below. Deployment has been tested in the following regions:

- (Africa) South Africa North
- (Asia Pacific) Australia East
- (Asia Pacific) Central India
- (Asia Pacific) Japan East
- (Asia Pacific) Southeast Asia
- (Asia Pacific) South India
- (Canada) Canada Central
- (Europe) France Central
- (Europe) Germany West Central
- (Europe) North Europe
- (Europe) UK South
- (Europe) West Europe
- (South America) Brazil South
- (US) Central US
- (US) East US
- (US) East US 2
- (US) South Central US
- (US) West Central US
- (US) West US 2

**Please open a pull request if you want to deploy the artifacts into a region that is not listed above.**

## Deployment

Now you have the following options for the deployment of the Mainframe Landing Zone:

1. Deploy to Azure Button

To use the Deploy to Azure Button, please click on the button below:

| Reference implementation   | Description | Deploy to Azure |
|:---------------------------|:------------|:----------------|
|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
