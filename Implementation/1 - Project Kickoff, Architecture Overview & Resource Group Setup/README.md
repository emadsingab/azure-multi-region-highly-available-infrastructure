# 1. Project Kickoff, Architecture Overview & Resource Group Setup 🚀

## 🎯 Phase Goal
Before deploying any infrastructure, it is crucial to establish a clear blueprint. The goal of this initial phase is to outline our implementation roadmap for building a highly available, multi-region enterprise architecture on Azure. Additionally, we will execute our first practical task: provisioning a centralized Resource Group to manage all project assets efficiently.

---

## 🗺️ The Implementation Roadmap (How We Will Proceed)
To build this robust, zero-downtime architecture, we will execute the deployment in a logical, step-by-step sequence:

1. **Networking Foundation:** We will start by building isolated Virtual Networks (VNets) in both the West US and East US regions, and establish Global VNet Peering to connect them securely.
2. **Secure Access:** We will deploy Azure Bastion to ensure we can manage our backend servers securely without exposing any public IP addresses to the internet.
3. **Compute & Load Balancing:** We will provision Virtual Machines within Availability Sets in both regions. These will be placed behind Regional Standard Load Balancers to ensure local high availability.
4. **Storage & Edge Caching:** We will set up dual Azure Blob Storage accounts with asynchronous Object Replication for disaster recovery. Azure Front Door (CDN) will then be implemented to serve static assets rapidly near the end-users.
5. **Global Traffic Routing:** Finally, we will deploy Azure Traffic Manager to act as our global DNS router, ensuring users are directed to the best-performing region and providing automatic failover in case of a complete regional disaster.

---

## 🛠️ Practical Task: Resource Group Initialization
To keep our lab environment organized, secure, and easy to manage (or tear down), all resources for this architecture will be deployed into a single, dedicated Resource Group.

### Steps Executed:
* Navigated to **Resource Groups** in the Azure Portal.
* Clicked **+ Create** to initiate the provisioning process.
* Created a new centralized Resource Group specifically named `RG-lab` and selected `(US) East US` as the primary deployment region to store its metadata.
* Successfully validated and deployed the resource group, making it visible in the central directory.

*(Implementation Evidence)*
![Navigate to RG](images/1%20-%20create%20RG.png)
![Click Create](images/1%20-%20create%20RG1.png)
![Configure RG Settings](images/1%20-%20create%20RG2.png)
![RG Created Successfully](images/1%20-%20create%20RG3.png)

---
*✅ Phase 1 Completed! The roadmap is set, the management container is ready, and we are now prepared to lay down the network foundation.*