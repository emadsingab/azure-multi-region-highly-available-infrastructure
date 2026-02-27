# 9. Deploy and Configure Azure Front Door (CDN) 🌍

## 🎯 Section Goal
Implement a Content Delivery Network (CDN) using Azure Front Door to globally distribute and cache website images. This ensures low-latency access for end-users worldwide and provides global high availability by load-balancing traffic across the regional storage accounts.

---

## 🚀 Implementation Steps

### Task 1: Provision Azure Front Door Profile
* Navigated to **Azure Front Door and CDN profiles** in the Azure Portal to initiate the deployment.
* Selected the **Quick create** option to streamline the deployment of a secure global CDN optimized for web applications.

*(Provisioning Evidence)*
![Search Front Door](images/1%20-%20create%20and%20configer%20front%20doors%20CDN.png)
![Quick Create](images/1%20-%20create%20and%20configer%20front%20doors%20CDN%201.png)

---

### Task 2: Configure Endpoint and Primary Origin
* Defined the endpoint hostname prefix as `images` (resulting in an Azure-provided FQDN).
* Configured the **Origin type** as `Storage (Azure Blobs)`.
* Selected the **East US Storage Account** (`emadstorageeast999.blob.core.windows.net`) as the primary origin host to fetch the image payloads.

### Task 3: Enable Optimization and Caching
To significantly reduce latency and bandwidth usage, the following performance optimizations were configured on the Front Door route:
* **Enable Caching:** Checked to allow Front Door edge nodes to cache the blob images closer to the users.
* **Enable Compression:** Checked to compress the files on the fly before delivering them to the client browser.

*(Endpoint & Caching Evidence)*
![Endpoint Configuration](images/1%20-%20create%20and%20configer%20front%20doors%20CDN%202.png)

---

### Task 4: Configure Global High Availability (Secondary Origin)
To ensure the global CDN remains functional even if the primary storage region experiences an outage, a secondary origin was added to the default origin group.
* Added a new origin named `emad west` pointing to the **West US Storage Account** (`emadstoragewest999.blob.core.windows.net`).
* Configured the priority and weight to establish a proper failover routing methodology across regions.

*(Origin Group Evidence)*
![Add Secondary Origin](images/add%20second%20oragin%20.jpg)

---
*✅ Phase 9 Completed Successfully! Static assets are now globally cached and highly available.*