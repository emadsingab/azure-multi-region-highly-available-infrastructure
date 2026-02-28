# 10. We Load-Balanced VMs Regionally, Why Not Route Traffic Globally Across Regions? 🌍

## 🎯 Section Goal
In this final phase, we transition from regional resilience to **Global High Availability**. We implement **Azure Traffic Manager** to route user traffic across different geographic regions based on performance (lowest latency). Furthermore, we execute rigorous disaster recovery testing to practically prove that the architecture survives both single-server crashes and total regional outages.

---

## 🚀 Practical Implementation Steps

### Task 1: Provision Azure Traffic Manager Profile
We began by setting up the core DNS-based routing service.
* Searched for and initiated the creation of a **Traffic Manager profile** in the Azure Portal.
* Created a new profile named `webproject` (resulting in `webproject.trafficmanager.net`) and explicitly set the routing method to **Performance**. This ensures end-users are automatically directed to the closest and fastest region.

*(Implementation Evidence - Provisioning)*
![Search Traffic Manager](images/1%20-%20create%20a%20traffice%20manager%20is%20a%20dns%20base%20routing.png)
![Configure Profile](images/1%20-%20create%20a%20traffice%20manager%20is%20a%20dns%20base%20routing%201.png)

---

### Task 2: Configure Global Endpoints (Linking the Regions)
To distribute the traffic, the regional Standard Load Balancers were attached to the Traffic Manager as external endpoints.
* **West US Endpoint:** Retrieved the Public IP of `LB-West` (`52.234.7.174`) and mapped it as an external endpoint named `EP-WestUS`.
* **East US Endpoint:** Retrieved the Public IP of `LB-East` (`20.106.157.177`) and mapped it as an external endpoint named `EP-EastUS`.

*(Implementation Evidence - Endpoints Configuration)*
![Empty Endpoints](images/2%20-%20configer%20end%20point%20front%20end%20ip%20so%20west%20LB.png)
![West LB IP](images/2%20-%20configer%20end%20point%20front%20end%20ip%20so%20west%20LB%201.png)
![West LB Endpoint](images/2%20-%20configer%20end%20point%20front%20end%20ip%20so%20west%20LB%202.png)
![East LB IP](images/3%20-%20configer%20end%20point%20front%20end%20ip%20so%20East%20LB%201.png)
![East LB Endpoint](images/3%20-%20configer%20end%20point%20front%20end%20ip%20so%20East%20LB%2012.png)

---

### Task 3: Web Server Customization (Preparation for Testing)
To accurately track which specific server responds during the failover tests, we customized the default web page on all backend virtual machines.
* Securely accessed the internal VMs (e.g., `EAST01`) using **Azure Bastion**, maintaining a secure posture by avoiding public RDP exposure.
* Opened **Internet Information Services (IIS) Manager** from the Server Manager dashboard.
* Opened the default `iisstart.htm` file in the `wwwroot` directory and replaced the code with a custom-branded HTML script prominently displaying the server's unique hostname.

*(Implementation Evidence - Secure Customization)*
![Bastion Access](images/4%20-%20use%20bastion%20to%20connect%20to%20change%20default%20web%20page.png)
![Open IIS Manager](images/4%20-%20use%20bastion%20to%20connect%20to%20change%20default%20web%20page1.jpg)
![IIS Explore](images/4%20-%20use%20bastion%20to%20connect%20to%20change%20default%20web%20page2.jpg)
![Open HTML](images/4%20-%20use%20bastion%20to%20connect%20to%20change%20default%20web%20page3.jpg)
![Edit HTML](images/4%20-%20use%20bastion%20to%20connect%20to%20change%20default%20web%20page4.jpg)

---

### Task 4: Global Failover & Disaster Recovery Validation 🛡️
This phase is the ultimate proof of the architecture's resilience. We monitored the Traffic Manager overview and queried the global URL under three distinct scenarios:

**1. Standard Operation (Optimal Routing):** Based on the performance routing method, Traffic Manager successfully routed the initial global request to the closest region (East US), specifically served by **`EAST01`**.
![TM Overview](images/5%20-%20validation.png)
![Standard Routing](images/5%20-%20validation1.png)

**2. Node-Level Failover (Single VM Crash):**
* **Action:** Forcefully stopped (deallocated) the `EAST01` VM to simulate a sudden hardware crash.
* **Result:** The regional Load Balancer detected the failure via its health probe and seamlessly shifted incoming traffic to the surviving node in the same region: **`EastUS02`**.
![Stop Server](images/5%20-%20validation2.png)
![Single VM Failover](images/5%20-%20validation%20one%20server%20failer.png)

**3. Total Regional Failover (Disaster Recovery):**
* **Action:** Simulated a complete regional data center outage by stopping ALL VMs in the East US region.
* **Result:** Traffic Manager detected the regional degradation and instantly re-routed global traffic to the secondary healthy region. The site remained entirely online, seamlessly served by **`WestUS02`**.
![Regional Failover](images/5%20-%20validation%20one%20regional%20failer.png)

---
*✅ Phase 10 Completed! The Enterprise Cloud Architecture is now fully deployed, practically validated, and proven to be globally fault-tolerant.*