# Mainframe file and tape backup to Azure using Luminex Mainframe Data Integration (MDI) and Channel Gateway X (CGX) CloudTAPE platforms

## Solution Overview
The Luminex MDI and CGX CloudTAPE platforms can be used to share Mainframe data with Azure. Examples include virtual tape backup and archive volumes, system management facilities (SMF) data, Virtual Storage Access Method (VSAM) datasets, sequential files, and generation data groups (GDGs). The MDI and CGX platform consist of hardware appliances that are installed in the datacenter.  These platforms connect to Azure through Expressroute or WAN.  ExpressRoute extends on-premises networks to the Microsoft cloud. ExpressRoute uses a connectivity provider to establish private connections between on-premises data and Microsoft cloud services. 
 
MDI and MVT use CGX controller devices that are based on the Fibre Connection (FICON) protocol. These devices connect directly to the mainframe. No System z Integrated Information Processor (zIIP) specialty engines are needed for data transfer and no TCP/IP ports need to be open for communication between the Mainframe and Luminex devices.

Luminex MDI zKonnect and other services stream the file data for big data analysis on Azure. For instance, system data like Mainframe logs and SMF data is streamed to Azure Event Hubs. Azure services ingest the data and then process, transform, and project it.

MDI uses Luminex CGX devices to process, transfer, and cache file data. Sharing data with Luminex MDI is generally initiated with Job control language (JCL) statements. Luminex provides statements that specify information about input files, the Azure destination, keys and security information, data transformation, and cloud file formats. Organizations that use the Luminex procedure for data transfer can use their own JCL statements. When the job finishes, a return code of zero indicates a successful transfer.
The job is monitored from the MDI UI. An operations team can use a combination of the scheduler, the mainframe, and the MDI UI to monitor and troubleshoot jobs. The MDI UI provides information like the job name, the job ID, the user or group, the start time, and the elapsed time. MDI retry mechanisms engage if the file transfer doesn't initially succeed.
The job can be configured to cache the files in local storage before the transfer. After the transfer finishes, that local storage is removed.

MVT CloudTAPE sends mainframe tape data to Azure data stores like Azure Blob Storage, Azure Files, and Azure Data Lake Storage. The data can be structured and unstructured. This data is sent directed to Azure based on the devices that it is written to, which can be managed by SMS or other decives steering methods. No additional JCL steps are needed to send the tape data to Azure, it is automatically transferred when it is sent to the device. MVT CloudTAPE moves or replicates mainframe tapes in IBM 3490 or 3590 format that CGX controllers emulate.

For either user case, you can also use this solution for bidirectional data interchange. You can recall the tape data to the mainframe and transform it into its original form.
With MDI, the process is similar to the transfer to Azure. You submit JCL statements that provide the specifics of the reverse transfer. The data can be transferred as tapes or as sequential files. The JCL configuration specifies the format.
With MVT CloudTAPE, the data is automatically recalled if you request it from the mainframe.


## Scenario details:
Mainframe physical storage can be located on the mainframe processor, or it can be external to the mainframe. Processor storage, which is like memory for the mainframe, is located on the processor. Disk drives and tape drives are examples of external storage. Datasets in storage are organized into various logical record and block structures. Parameters like the dataset organization (DSORG) and record format (RECFM) define these data structures. Records in the dataset can be fixed or variable in length, and they can be stored in binary or text format.
Secondary storage devices like DASDs and SASDs store data that's either frequently or infrequently accessed.
DASDs are used for immediate data location and retrieval. With direct access, you can read or write data by going directly to a specific physical location on the device. As a result, DASDs are fast and efficient.
SASDs, such as tapes, are inherently slower than DASDs. To access tape data, you start at one location and then go through successive locations until you find the data that you need. Mainframes use physical tapes and virtual tape libraries (VTLs), which are also called virtual tapes. Currently, virtual tapes are preferred over physical tapes.
The type of storage that you use depends on your needs. Many organizations need cold storage for compliance, regulatory, reporting, audit, or other purposes. Some organizations have data retention policies that require you to store data for nearly 100 years. Examples of this type of data include copies of prescriptions, patient records, customer reward history, and other information. Data that you store for the long term is mostly high in volume and accessed infrequently. Long-term storage generally costs less than active storage, which you typically access multiple times a day and which is frequently updated. Security considerations also affect your choice of storage. Cyberattacks are a constant threat.
Azure offers various storage solutions and is a proven landing place for your storage, backup, and long-term archival needs. You can use cold storage for infrequently accessed data and hot storage for frequently accessed data. Mainframe file structures, such as VSAM datasets, flat files, and tape data, map to Azure data constructs within databases, structured files, and blob storage. Azure storage can store volume-intense data with cost efficiency, scalability, replication, and self-sustainability. Azure services can also help you retrieve your data, visualize your data, and gain insights from your data.
The solution in this article uses the Luminex MDI and MVT platforms to transfer mainframe data to and from Azure to meet backup, archival, and other business needs.
Luminex MDI is a data transfer and coprocessing platform. MDI uses Luminex CGX devices to process, transfer, and cache mainframe files. MDI provides secure and efficient exchange of data and workload sharing between z/OS mainframes and distributed systems. By using MDI products like Cloud Data Sharing, Big Data Transfer, and zKonnect, you can move files to Azure for backup, archival, data normalization, merging, and analysis. You can configure the transferred data to arrive in ASCII or EBCDIC format in Azure. MDI Cloud Data Sharing provides a way to migrate mainframe files like VSAM files, sequential files, and GDGs to Azure. MDI also supports integration with Azure messaging services. Applications that are hosted on Azure can use the mainframe files that are stored on Azure for modernization, reduced latency, and improved performance.


Luminex MVT is a tape archival and backup platform. MVT uses Luminex CGX control unit software that emulates mainframe 3490 and 3590 tape drives, so you can use existing tape applications without change. The CGX environment provides a suite of products for tape encryption, vaulting, migration, replication, retrieval, disaster recovery, and high availability. Specifically, the CloudTAPE product provides a way to migrate tape data to Azure.
MDI and MVT both use high-speed CGX controller devices to connect directly to the mainframe. These controllers are based on FICON, a transport protocol that mainframe servers and attached enterprise-class storage controllers support. FICON uses Fibre Channel as the underlying transport protocol. The CGX controllers also take advantage of network attached storage (NAS) and internal storage systems to supply the high levels of performance, scalability, reliability, security, and availability that enterprises demand. With FICON transport, I/O can be shared across multiple systems. FICON delivers optimal protocol efficiency. It also helps provide data integrity and security, even with increased distances between server and storage devices.
With MDI and MVT, no zIIP specialty engines are needed for data transfer, and no TCP/IP ports need to be open to enable communication between the mainframe and Luminex devices. You plug the Luminex CGX devices directly into the mainframe just like any other mainframe storage device. If necessary, your existing legacy backup and tape management software can run in parallel. For MVT CloudTAPE and MDI Cloud Data Sharing, the millions of instructions per second (MIPS) consumption is minimal because the transfer uses lightweight processes.
Potential use cases

## Many scenarios can benefit from this solution. Possibilities include organizations with the following goals:
Minimizing tape management and maintenance efforts.
Modernizing legacy workloads.
Finding backup and archival solutions.
Extending their mainframe modernization by moving mainframe tapes to the cloud. Organizations might have this goal if they want to downsize their datacenter but not abandon it. If an organization doesn't use mainframe tapes heavily, the tapes might be a suitable candidate for migration.
Transforming migrated data into a different format for cloud storage, such as converting EBCDIC data to ASCII, VSAM files to JSON, and sequential data to CSV format.
Transferring tape metadata to Azure storage metadata.
Providing new and refactored applications that are hosted on Azure with easy access to data.
Expanding their cloud footprint.
Easily monitoring, displaying, and reporting on mainframe files and tape data, and integrating this data with Azure services.
Monetizing current and historical unlocked mainframe data and using it in cloud business intelligence and analytics tools.
If you're implementing a similar solution and want to share your experiences or feedback, contact the Microsoft Legacy Modernization Azure Core Engineering (ACE) team.
Considerations
These considerations implement the pillars of the Azure Well-Architected Framework, which is a set of guiding tenets that can be used to improve the quality of a workload. For more information, see Microsoft Azure Well-Architected Framework.

## Reliability
Reliability ensures your application can meet the commitments you make to your customers. For more information, see Overview of the reliability pillar.
You can deploy this solution in multiple regions, and you can implement geo-replication in the data layer. Azure auto-failover groups also help provide data protection.
Clustered CGX controllers can provide an active-active recovery solution during a failure.
MVT Synchronous Tape Matrix provides reliability across multiple datacenters. Its infrastructure adjusts to failures without interruption.
Luminex Replication can replicate data to one or many targets. A target can be one or more disaster recovery sites that each have a mainframe and CGX controller installed on the property. You can also preconfigure a target through Azure geo-replication. If you use Azure and other private or public clouds, you can also use a hybrid strategy for disaster recovery. Essentially, you can use the replication strategy that best meets your requirements. Examples include one-to-one, one-to-many, many-to-many, and cascading strategies.

## Security
Security provides assurances against deliberate attacks and the abuse of your valuable data and systems. For more information, see Overview of the security pillar.
The fully managed storage in this solution eliminates issues that are related to physical media safety. Examples are damage or unauthorized access that might occur when you ship physical tapes in vehicles.
Luminex CGSafe provides tape compression and encryption. This product is part of the MVT family and is included with CloudTAPE. CGSafe encrypts and compresses tapes during ingestion, at rest, and in transit.
When you use MDI Cloud Data Sharing, files are sent over HTTPS by using SSL. In Azure, you can encrypt the files at rest.
Because the solution uses FICON and ESCON connectivity, you don't need to open any ports for data transfer.

## Cost optimization
Cost optimization is about looking at ways to reduce unnecessary expenses and improve operational efficiencies. For more information, see Overview of the cost optimization pillar.
Pay-as-you-go pricing and multi-tiered models in Azure provide options to suit various cost and performance needs. For instance, if you access data infrequently, the Azure cool access tier is a good option for low-cost storage.
The pricing of this solution depends on your volume of tape data, your datacenter location, and your bandwidth. The cost also depends on which Azure services you use. These factors determine the hardware that you use, such as the number of Luminex CGX controllers. The factors also affect your software, service, licensing, and support costs.
The data interchange doesn't require zIIP processors. As a result, you save on costs when you run the software.
After the Luminex infrastructure is in place, you can use the Luminex hardware for other purposes. For instance, you might already use MDI Cloud Data Sharing for file transfer. If you augment your environment with MDI zKonnect for streaming, you can save on costs because you can purchase additional Luminex software and infrastructure at a significantly reduced price.
If you already have an ExpressRoute infrastructure in place, you can use it for this solution.
Using Azure and Luminex for backup and recovery helps you eliminate some costs that are associated with physical tape infrastructure. Examples include media and shipping expenses and off-site storage for vaulting.

## Operational excellence
Operational excellence covers the operations processes that deploy an application and keep it running in production. For more information, see Overview of the operational excellence pillar.
The data transfer to Azure in this solution gives you flexibility when you develop a backup strategy. You can enable automated, regular migration or phased-data migration. After you've installed a Luminex device in your datacenter, you can configure unidirectional or bidirectional communication, staged migration, or one-time migration. This flexibility provides support for implementing DevOps and Agile working principles and for immediate cloud adoption.
You can take advantage of Azure capabilities for mainframe backup, archive, and disaster recovery.
You can deploy continuous integration/continuous delivery (CI/CD) pipelines on Azure to manage data movement, transformation, and control activities.

## Performance efficiency
Performance efficiency is the ability of your workload to scale to meet the demands placed on it by users in an efficient manner. For more information, see Performance efficiency pillar overview.
If you have a high volume of data, you can cluster CGX controllers. Typically, one CGX device offers a data-transfer speed of up to 800 megabytes per second (MB/s). CGX controllers are available with up to four Fibre Channel ports or 1 Gigabit Ethernet (GbE), 10 GbE, or 25 GbE. These controllers also offer up to four ports for connectivity to attached storage systems.
In Azure services, various performance options and tiers are available. For instance, block blob storage accounts offer standard and premium performance tiers. You can choose the tier that best meets your needs.
Predefined access and life cycle management in Azure make it easy to optimize the performance of specific use cases.
The tape emulation software in this solution uses the FICON I/O system. By using this system, you can reduce CPU time, increase data transmission speed, and reduce elapsed time.

## Reference Architecture

![image](./images/Luminex_ALZ_Visio.png)

Dataflow
1.	On a mainframe, secondary storage devices include direct-access storage devices (DASDs) and sequential-access storage devices (SASDs).
2.	DASDs are mounted on the mainframe.
3.	A tape is a type of SASD that's attached to the mainframe as external storage.
4.	The MDI platform sends information that can be stored on files to Azure. Examples include system management facilities (SMF) data, Virtual Storage Access Method (VSAM) files, sequential files, and generation data groups (GDGs). MDI hardware that's installed in the datacenter includes Luminex Channel Gateway X (CGX) controllers and Luminex MDI servers.
5.	MVT CloudTAPE provides tape archival and backup. MVT hardware that's installed in the datacenter includes Luminex CGX controllers and CloudTAPE servers.
6.	MDI and MVT use CGX controller devices that are based on the Fibre Connection (FICON) protocol. These devices connect directly to the mainframe. No System z Integrated Information Processor (zIIP) specialty engines are needed for data transfer. There's no Luminex agent on the mainframe, and no TCP/IP ports need to be open for communication between the mainframe and Luminex devices.
7.	The mainframe data is transferred to Azure through a private, secure Azure ExpressRoute connection.
8.	Luminex MDI zKonnect and other services stream the file data for big data analysis on Azure. For instance, system data like mainframe logs and SMF data is streamed to Azure Event Hubs. Azure services ingest the data and then process, transform, and project it.
9.	MDI uses Luminex CGX devices to process, transfer, and cache file data. Two options are available:
•	Job control language (JCL) statements are submitted. Luminex provides statements that specify information about input files, the Azure destination, keys and security information, data transformation, and cloud file formats. Organizations that use the Luminex procedure for data transfer can use their own JCL statements. When the job finishes, a return code of zero indicates a successful transfer.
•	The job is monitored from the MDI UI. An operations team can use a combination of the scheduler, the mainframe, and the MDI UI to monitor and troubleshoot jobs. The MDI UI provides information like the job name, the job ID, the user or group, the start time, and the elapsed time. MDI retry mechanisms engage if the file transfer doesn't initially succeed.
The job can be configured to cache the files in local storage before the transfer. After the transfer finishes, that local storage is removed.
10.	MVT CloudTAPE sends mainframe tape data to Azure data stores like Azure Blob Storage, Azure Files, and Azure Data Lake Storage. The data can be structured and unstructured. The transfer doesn't use JCL statements. Instead, MVT CloudTAPE moves or replicates mainframe tapes in IBM 3490 or 3590 format that CGX controllers emulate.
11.	Azure services provide data processing, storage, analytics, and visualization capabilities.



For more information on the Luminex MDI and CGX solutions, please visit the following links:
[Luminex MDI] (https://luminexmdi.com)
[Luminex] (https://luminex.com)
