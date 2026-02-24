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