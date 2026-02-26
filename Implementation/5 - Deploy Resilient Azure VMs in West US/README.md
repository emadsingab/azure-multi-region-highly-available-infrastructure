# 5. Deploy Resilient Azure VMs in West US 🖥️

## 🎯 Section Goal
Deploy scalable and highly available Windows Virtual Machines in the West US region. These VMs will act as the backend web servers for our regional Load Balancer and form the compute foundation of this infrastructure.

---

## 📚 Theoretical Concepts

### What is an Azure Virtual Machine?
An Azure VM is an on-demand computing resource used for running applications and workloads. It provides flexible compute configurations, scalability, and seamless integration with other Azure services like load balancers and virtual networks.

### Importance of an Availability Set
An Availability Set is a logical grouping capability that ensures VM redundancy by distributing instances across different physical hosts within a datacenter. This protects the infrastructure against underlying hardware failures and planned maintenance events.

### Remote Deployment Methods
- **Azure Bastion:** Provides secure and seamless RDP connectivity to VMs directly from the Azure portal over TLS.
- **Run Command Feature:** A secure feature that allows the remote execution of scripts (like PowerShell) directly on the VM without requiring RDP access. This ensures consistent and rapid deployment.

---

## 🚀 Implementation Steps

### Task 1: Provisioning `WEST01` and Availability Set

1. **Initiate VM Creation:** Searched for **Virtual machines** in the Azure Portal to begin deployment.
   ![Search VMs](images/1%20-%20Deploy%20and%20Configure%20WEST01.png)

2. **Create Availability Set:** Created a new availability set named `AvailSet-West` configured with 2 Fault domains and 6 Update domains to ensure physical redundancy for the workloads.
   ![Create Availability Set](images/1%20-%20Deploy%20and%20Configure%20WEST01%201.png)

3. **Configure VM Basics:** Provisioned the first Windows Virtual Machine named `WEST01` in the `West US` region, assigning it to the newly created `AvailSet-West`.
   ![VM Basics](images/1%20-%20Deploy%20and%20Configure%20WEST01%202.png)

4. **Disk Configuration:** Selected Standard SSD for the OS disk type.
   ![VM Disks](images/1%20-%20Deploy%20and%20Configure%20WEST01%203.png)

5. **Networking & Load Balancer Integration:** Configured the advanced NIC NSG (`WEST01-BE-Pool-nsg`). Crucially, placed the VM behind the regional load balancer by adding it to the `BE-pool` backend pool of `LB-West`.
   ![Networking and LB](images/1%20-%20Deploy%20and%20Configure%20WEST01%204.png)

---

### Task 2: Provisioning `WestUS02`

1. **Configure Basics for Second VM:** Provisioned the second VM named `WestUS02` in the `West US` region, ensuring it was securely added to the same `AvailSet-West` availability set for high availability.
   ![WEST02 Basics](images/3%20-%20Deploy%20and%20Configure%20WEST02%201.png)

2. **Networking & LB Integration:** Configured the networking for `WestUS02` by attaching it to `Subnet-West`, disabling the Public IP (None), and securely placing it in the `BE-pool` backend pool behind `LB-West`.
   ![WEST02 Networking](images/3%20-%20Deploy%20and%20Configure%20WEST02%202.png)

---

### Task 3: Install IIS Web Server on `WEST01` (GUI Method via Bastion)

1. **Connect securely:** Used Azure Bastion to establish an RDP session directly within the browser.
   ![Connect via Bastion](images/2%20-%20Install%20IIS%20on%20WEST01%20using%20bastion%201.png)
2. **Server Manager:** Navigated to **Add roles and features** from the Server Manager Dashboard.
   ![Server Manager](images/2%20-%20Install%20IIS%20on%20WEST01%20using%20bastion%202.png)
3. **Select Role:** Selected the **Web Server (IIS)** role and included the necessary management tools.
   ![Select IIS](images/2%20-%20Install%20IIS%20on%20WEST01%20using%20bastion%203.jpg)
4. **Confirm Installation:** Completed the installation wizard.
   ![Confirm Install](images/2%20-%20Install%20IIS%20on%20WEST01%20using%20bastion%204.png)

---

### Task 4: Install IIS Web Server on `WestUS02` (Automation Method via Run Command)

- Executed the `RunPowerShellScript` command `Install-WindowsFeature Web-Server -IncludeManagementTools` directly from the Azure Portal, yielding a successful exit code.
  ![Run Command](images/2%20-%20Install%20IIS%20on%20WEST02%20by%20using%20run%20command%20option.png)

---

## ✅ Final Verification
Both `WEST01` and `WestUS02` are successfully joined to the `RG-LAB` resource group, displaying a `Running` status. Both VMs correctly reflect the Public IP address of the `LB-West` frontend, confirming successful load balancer integration.

![VMs Running](images/image_5ee99f.png)

---
*✅ Phase 5 Completed Successfully!*