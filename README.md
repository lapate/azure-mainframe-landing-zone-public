# Legacy workload - Mainframe Landing Zone

## Objective

The [Mainframe Landing Zone](https://aka.ms/adopt/cloudscaleanalytics) provides a prescriptive solution platform design coupled with Azure best practices and design principles. These principles serve as a compass for subsequent design decisions across critical technical domains. The architecture will continue to evolve alongside the Azure platform and is ultimately driven by the various design decisions that organizations must make to define their legacy workload journey.

The Mainframe Landing Zone architecture consists of two core building blocks:

1. *Azure Landing Zone hub* which provides all centralized network traffic management capabilities for the solution platform and on-premises connectivity of an organization.
1. *Mainframe Landing Zone* which is a logical construct and a unit in the mainframe workload solution architecture that enables execution of Mainframe modernization components.

---

*The Mainframe Landing Zone architecture represents the strategic design path and target technical state for your Mainframe workloads on Azure data platform.*

---

This repository describes the Mainframe Landing Zone, which is where 

> **Note:** Before getting started with the deployment, please make sure you are familiar with the [complementary documentation in the Cloud Adoption Framework](https://aka.ms/adopt/datamanagement). Also, before deploying your first Mainframe Landing Zone, please make sure that you have deployed a [Azure Core Landing Zone](https://github.com/Azure/data-management-zone).

## Deploy Cloud-scale Analytics

All building blocks can be deployed through the Azure Portal as well as through GitHub Actions workflows and Azure DevOps Pipelines. The template repositories contain sample YAML pipelines to more quickly get started with the setup of the environments.

| Reference implementation   | Description | Deploy to Azure | Link |
|:---------------------------|:------------|:----------------|------|

| Mainframe Landing Zone          | Deploys a single Mainframe Landing Zone to a subscription. Please deploy a [Azure Core Landing Zone](https://github.com/Azure/data-management-zone) first. |[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fmainframe-landing-zone%2Fmain%2Finfra%2Fmain.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fmainframe-landing-zone%2Fmain%2Fdocs%2Freference%2Fportal.mainframeLandingZone.json) | [Repository](https://github.com/Azure/mainframe-landing-zone) |

## Deploy Mainframe Landing Zone

To deploy the Mainframe Landing Zone into your Azure Subscription, please follow the step-by-step instructions:

1. [Prerequisites](/docs/Mainframe-Prerequisites.md)
2. [Create repository](/docs/Mainframe-CreateRepository.md)
3. [Setting up Service Principal](/docs/Mainframe-ServicePrincipal.md)
4. Template Deployment
    1. [GitHub Action Deployment](/docs/Mainframe-GitHubActionsDeployment.md)
    2. [Azure DevOps Deployment](/docs/Mainframe-AzureDevOpsDeployment.md)
5. [Known Issues](/docs/Mainframe-KnownIssues.md)

## Contributing

Please review the [Contributor's Guide](./CONTRIBUTING.md) for more information on how to contribute to this project via Issue Reports and Pull Requests.
