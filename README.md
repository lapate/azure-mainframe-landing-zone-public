# Azure Landing Zone Accelerator for Modernized Mainframe and Midrange workloads

This provides a prescriptive solution platform design coupled with Azure best practices and design principles. These principles serve as a compass for subsequent design decisions across critical technical domains. The architecture will continue to evolve alongside the Azure platform and is ultimately driven by the various design decisions that organizations must make to define their legacy workload journey.

The architecture consists of two core building blocks:

1. *Azure Core Landing Zone hub* - provides all centralized network traffic management capabilities for the solution platform and on-premises connectivity of an organization.
2. *Solution Specific Landing Zone* - is a logical construct and a unit in the solution architecture that enables execution of Mainframe, Midrange modernization components.

---
![mainframe,midrange architecture](/docs/images/malz.png)

*This Landing Zone architecture represents the strategic design path and target technical state for your Mainframe, Midrange workloads on the Azure platform.*

---

> **Note:** Before getting started with the deployment, please make sure you are familiar with the [complementary documentation in the Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/).

## Architecture Elements

The enterprise architecture is broken down into six different design areas, where you can find the links to each at:

1. Input comes from remote clients via ExpressRoute, or from other Azure users. TCP/IP is the primary way to connect to the system. On-premises users can access web-based applications over Transport Layer Security (TLS) port 443.
2. Azure Load Balancer manages access to the application compute clusters. Load Balancer supports scale-out compute resources to handle input.
3. Application compute clusters run on Azure VMs. Compute resources use solid-state drive (SSD) managed disks with Accelerated Networking.
4. Application servers in the compute clusters host the applications based on language capability, such as Java classes or COBOL programs. The servers receive application input, and share application state and data by using Azure SQL database.
5. Data services in the application clusters support multiple connections to persistent data sources. Azure Private Link provides private connectivity from within the virtual network to Azure services.
6. Data storage consists of high-performance storage with premium SSD disks, Azure Files, and standard storage, including blob, archive, and backup storage.
7. Azure PaaS data services provide scalable and highly available data storage that you can share among compute cluster resources.
8. Services can easily integrate with the modernized system.

## Prerequisites

Please ensure you have verified and completed all prerequisites described here

[Prerequisites](/docs/Mainframe-Prerequisites.md)

## Deploy the Azure Landing Zone for Modernized Mainframe & Midrange  workloads

To deploy the Landing Zone into your Azure Subscription, please follow the step-by-step instructions:

1. Select and deploy one of reference implementations below:

| Reference implementation   | Deploy to Azure |
|:---------------------------|:----------------|
|[ Generic Containerized Solution](/docs/Solutions/genericaks/generic-aks.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
|[ Raincode Metal Linux Solution](/docs/Solutions/raincode/raincode.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
|[ Stromasys Solution](/docs/Solutions/stromasys/stromasys.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
|[ Opentext Solution](/docs/Solutions/opentext/opentext.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
|[ TmaxSoft Solution](/docs/Solutions/tmaxsoft/tmaxsoft.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
|[ Luminex Solution](/docs/Solutions/luminex/luminex.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
|[ Tidal Solution](/docs/Solutions/tidal/tidal.md)|[![`DTA-Button-ALZ`](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://ms.portal.azure.com/#view/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Finfra%2Fmain-template%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2Flapate%2Fazure-mainframe-landing-zone-public%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json)|
---
## Share Feedback

Please leverage issues if you have any feedback or would like to submit a request to improve the solution hosted in this repository.

---
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services.

### Telemetry Configuration

Telemetry collection is on by default.

---


## Contributing

Please review the [Contributor's Guide](./CONTRIBUTING.md) for more information on how to contribute to this project via Issue Reports and Pull Requests.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
