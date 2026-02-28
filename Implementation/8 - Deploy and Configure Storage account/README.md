# 8. Deploy and Configure Azure Blob Storage Accounts 🗄️

## 🎯 Section Goal
Establish a highly available and fault-tolerant centralized repository for website images. This is achieved by deploying two Azure Blob Storage Accounts across different regions and implementing Object Replication to ensure business continuity and automatic data synchronization.

---

## 🚀 Implementation Steps

### Task 1: Provision Storage Accounts
Two standard storage accounts were provisioned to serve as the regional storage endpoints.
* **Initiate Creation:** Searched for Storage Accounts to begin the deployment process.
* **West US Storage:** Created `emadstoragewest999` in the West US region with Locally-redundant storage (LRS). Critically, **Allow enabling anonymous access on individual containers** was explicitly enabled to permit public read access.
* **East US Storage:** Created the secondary account `emadstorageeast999` in the East US region, maintaining identical LRS and access configurations.

*(Deployment Evidence)*
![Search Storage](images/1%20-%20Deploy%20and%20Configure%20Storage.png)
![West US Account](images/1%20-%20Deploy%20and%20Configure%20Storage%20WestUS.png)
![Enable Anonymous Access](images/1%20-%20Deploy%20and%20Configure%20Storage%20WestUS%201.png)
![East US Account](images/3%20-%20Deploy%20and%20Configure%20Storage%20EastUS.png)

---

### Task 2: Configure RBAC and Blob Containers
To properly manage and expose the stored images, precise role-based access control and container permissions were established.
* **RBAC Assignment:** Navigated to the Access Control (IAM) blade and assigned the `Storage Blob Data Contributor` role to the admin user.
* **Container Creation:** Accessed the Containers blade and created a new container named `images`.
* **Public Access:** Configured the container's access level to **Container (anonymous read access for containers and blobs)**, allowing the front-end to render images seamlessly.

*(Security & Container Evidence)*
![IAM Configuration](images/2%20-%20add%20RBAC%20to%20user%20to%20can%20access%20the%20data%20in%20blob.png)
![RBAC Role](images/2%20-%20add%20RBAC%20to%20user%20to%20can%20access%20the%20data%20in%20blob%201.png)
![Create Container](images/2%20-%20create%20a%20blob%20storage%201.png)

---

### Task 3: Implement Object Replication for High Availability
To ensure fault tolerance, an Object Replication rule was implemented to automatically mirror data between the two regions.
* Navigated to the **Object replication** blade under Data management.
* Created a replication rule setting `emadstorageeast999` as the source and `emadstoragewest999` as the destination.
* Mapped the source `images` container to the destination `images` container, configuring the filter to copy **Everything**.

*(Replication Evidence)*
![Object Replication Blade](images/4%20-%20create%20object%20replication.png)
![Replication Rule](images/4%20-%20create%20object%20replication%201.png)

---

### Task 4: Validate Asynchronous Replication
A validation test was performed to confirm that the replication pipeline was successfully synchronizing data across regions.
* Uploaded a test image named `cloud-network.png` directly to the `images` container within the **East US** (`emadstorageeast999`) storage account.
* Monitored the destination **West US** (`emadstoragewest999`) storage account and confirmed that `cloud-network.png` successfully and automatically replicated to its `images` container.

*(Validation Evidence)*
![Upload Blob](images/5%20-%20validation%20object%20replication%201.png)
![Validation Test Success](images/5%20-%20validation%20object%20replication%202.png)

---
*✅ Phase 8 Completed Successfully! The storage layer is now globally redundant and fault-tolerant.*