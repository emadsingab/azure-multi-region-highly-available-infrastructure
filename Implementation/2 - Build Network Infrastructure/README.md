# 2. Build Network Infrastructure 🌐

## 🎯 Section Goal
The end goal of this section is to successfully deploy a resource group, two virtual networks, two subnets, and two NAT gateways. 

---

## 🚀 Task 1: Provisioning the Central Resource Group

**Theoretical Concept:**
An Azure Resource Group is a logical container for managing related Azure resources. It simplifies resource management by grouping related assets, supports lifecycle management (deleting the group removes all associated resources), and enables security policies at the group level. For this project, all lab resources are deployed within `RG-Lab` to facilitate consistency and simplified administration. The chosen region dictates where the metadata for this group is stored.

**Implementation Steps:**

1. **Navigate to Resource Groups:** Accessed the Azure Portal and selected the **Resource groups** service from the main dashboard.
   ![Navigate to RG](images/1%20-%20create%20RG.png)

2. **Initiate Creation:** Clicked on the **+ Create** button to start the deployment process.
   ![Click Create](images/1%20-%20create%20RG1.png)

3. **Configure Settings:** Configured the basic project details:
   - **Subscription:** Selected the active Azure subscription.
   - **Resource group name:** `RG-lab`.
   - **Region:** `(US) East US`.
   - Clicked on **Review + create** to validate the configuration.
   ![Configure RG Settings](images/1%20-%20create%20RG2.png)

4. **Verify Deployment:** After successful validation and creation, the new `RG-lab` resource group is now visible and active in the central Resource groups list.
   ![RG Created Successfully](images/1%20-%20create%20RG3.png)

---

## 🚀 Task 2: Deploying Virtual Networks (vNets) and Subnets

**Theoretical Concept:**
Azure Virtual Network (vNet) is the fundamental building block for your private network in Azure, enabling resources to securely communicate with each other, the internet, and on-premises networks. They provide the logical separation and traffic control necessary for efficient cloud management. 

**Implementation Steps:**

1. **Navigate to Virtual Networks:** Searched for and selected **Virtual networks** from the Azure Portal services. Clicked on **+ Create** to begin provisioning.

2. **Provision `vNet-West`:**
   - **Basics:** Deployed within the `RG-lab` resource group in the `West US` region.
   - **IP Addresses:** Allocated the address space `10.0.0.0/16`. Created a dedicated subnet named `Subnet-West` with the starting address `10.0.1.0` and a `/24` size (`10.0.1.0/24`).
   ![vNet-West Basics](images/2%20-%20Deploy%20vNetWest%20and%20SubnetWest2.png)
   ![vNet-West Subnet](images/2%20-%20Deploy%20vNetWest%20and%20SubnetWest3.png)

3. **Provision `vNet-East`:**
   - **Basics:** Deployed the second vNet within the `RG-lab` resource group, but in the `East US` region to support multi-region high availability.
   - **IP Addresses:** Allocated a distinct address space `10.1.0.0/16` to prevent overlapping. Created a subnet named `Subnet-East` with the starting address `10.1.1.0` and a `/24` size (`10.1.1.0/24`).
   - Clicked **Review + create** and successfully validated the deployment.
   ![vNet-East IP Configuration](images/3%20-%20Deploy%20vNet-East1.png)
   ![vNet-East Deployment](images/3%20-%20Deploy%20vNet-East2.png)

---

## 🚀 Task 3: Deploying NAT Gateways

**Theoretical Concept:**
Azure NAT Gateways manage secure and highly resilient outbound internet connectivity for virtual machines. This setup allows internal resources to communicate securely with the outside world (e.g., to download software updates) without exposing them to direct inbound internet traffic. Key configurations include assigning gateway names, locations, creating Public IP addresses, and defining subnet associations.

**Implementation Steps:**

1. **Navigate to NAT Gateways:** Searched for **NAT gateways** in the Azure Portal and clicked **+ Create**.
   ![Navigate to NAT Gateways](images/4%20-%20Deploy%20NAT-West%20Gateway.png)

2. **Provision `NAT-West`:**
   - **Basics:** Selected the `RG-lab` resource group, named the gateway `NAT-West`, and deployed it in the `West US` region.
   - **Outbound IP:** Created a new standard static Public IP address named `PIP-NATWest`.
   - **Networking:** Associated the gateway specifically with `vNet-West` and its corresponding `Subnet-West`. Validated and deployed.
   ![Deploy NAT-West Basics](images/4%20-%20Deploy%20NAT-West%20Gateway1.png)
   ![NAT-West Networking](images/4%20-%20Deploy%20NAT-West%20Gateway3.png)

3. **Provision `NAT-East`:**
   - **Basics & IP:** Configured the second gateway named `NAT-East` in the `East US` region within `RG-lab`. Created a new Public IP named `PIP-NATEast`.
   - **Networking:** Associated the gateway securely with `vNet-East` and `Subnet-East`. Clicked **Create** to complete the foundational network phase.
   ![Deploy NAT-East](images/4%20-%20Deploy%20NAT-East%20Gateway.png)
   ![NAT-East Validation](images/4%20-%20Deploy%20NAT-East%20Gatewa1.png)

---
*✅ Phase 2 Completed Successfully!*