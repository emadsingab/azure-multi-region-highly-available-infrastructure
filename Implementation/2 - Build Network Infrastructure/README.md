# 2. Build Network Infrastructure 🌐

## 🎯 Section Goal
The end goal of this section is to successfully deploy a robust network foundation. This includes deploying two logically isolated virtual networks (vNets), two subnets, and two NAT gateways to securely manage outbound traffic.

---

## 🚀 Task 1: Deploying Virtual Networks (vNets) and Subnets

**Theoretical Concept:**
Azure Virtual Network (vNet) is the fundamental building block for your private network in Azure, enabling resources to securely communicate with each other and the internet. They provide the logical separation and traffic control necessary for efficient cloud operations.

**Implementation Steps:**

1. **Navigate to Virtual Networks:** Searched for and selected **Virtual networks** from the Azure Portal services. Clicked on **+ Create** to begin provisioning.

2. **Provision `vNet-West`:**
   - **Basics:** Deployed the network within the `RG-lab` resource group in the `West US` region.
   - **IP Addresses:** Allocated the address space `10.0.0.0/16`. Created a dedicated subnet named `Subnet-West` with the starting address `10.0.1.0` and a `/24` size (`10.0.1.0/24`).

*(Implementation Evidence - West US)*
![Navigate vNet](images/2%20-%20Deploy%20vNetWest%20and%20SubnetWest.png)
![Create vNet](images/2%20-%20Deploy%20vNetWest%20and%20SubnetWest1.png)
![vNet-West Basics](images/2%20-%20Deploy%20vNetWest%20and%20SubnetWest2.png)
![vNet-West Subnet](images/2%20-%20Deploy%20vNetWest%20and%20SubnetWest3.png)

3. **Provision `vNet-East`:**
   - **Basics:** Deployed the second vNet within the `RG-lab` resource group in the `East US` region to establish our multi-region high availability architecture.
   - **IP Addresses:** Allocated a distinct address space `10.1.0.0/16` to prevent overlapping. Created a subnet named `Subnet-East` with the starting address `10.1.1.0` and a `/24` size (`10.1.1.0/24`).
   - Clicked **Review + create** and successfully validated the deployment.

*(Implementation Evidence - East US)*
![vNet-East Basics](images/3%20-%20Deploy%20vNet-East.png)
![vNet-East IP Configuration](images/3%20-%20Deploy%20vNet-East1.png)
![vNet-East Deployment](images/3%20-%20Deploy%20vNet-East2.png)

---

## 🚀 Task 2: Deploying NAT Gateways

**Theoretical Concept:**
Azure NAT Gateways manage secure and highly resilient outbound internet connectivity for virtual networks. This setup allows internal resources to communicate securely with the outside world (e.g., to download software updates) without exposing them to direct inbound internet traffic.

**Implementation Steps:**

1. **Navigate to NAT Gateways:** Searched for **NAT gateways** in the Azure Portal to initiate the deployment.

2. **Provision `NAT-West`:**
   - **Basics:** Selected the `RG-lab` resource group, named the gateway `NAT-West`, and deployed it in the `West US` region.
   - **Outbound IP:** Created a new standard static Public IP address named `PIP-NATWest`.
   - **Networking:** Associated the gateway specifically with `vNet-West` and its corresponding `Subnet-West`. Validated and deployed.

*(Implementation Evidence - NAT West)*
![Navigate to NAT Gateways](images/4%20-%20%20Deploy%20NAT-West%20Gateway.png)
![Deploy NAT-West Basics](images/4%20-%20%20Deploy%20NAT-West%20Gateway1.png)
![NAT-West IP](images/4%20-%20%20Deploy%20NAT-West%20Gateway2.png)
![NAT-West Networking](images/4%20-%20%20Deploy%20NAT-West%20Gateway3.png)
![NAT-West Review](images/4%20-%20%20Deploy%20NAT-West%20Gateway4.png)

3. **Provision `NAT-East`:**
   - **Basics & IP:** Configured the second gateway named `NAT-East` in the `East US` region within `RG-lab`. Created a new Public IP named `PIP-NATEast`.
   - **Networking:** Associated the gateway securely with the `vNet-East` virtual network and the `Subnet-East` subnet. Clicked **Create** to successfully complete the foundational network phase.

*(Implementation Evidence - NAT East)*
![Deploy NAT-East](images/4%20-%20%20Deploy%20NAT-East%20Gateway.png)
![NAT-East Validation](images/4%20-%20%20Deploy%20NAT-East%20Gatewa1.png)

---
*✅ Phase 2 Completed Successfully! The secure networking foundation is now established and ready for backend deployment.*