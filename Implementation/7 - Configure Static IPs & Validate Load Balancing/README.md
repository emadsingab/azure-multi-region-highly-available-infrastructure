# 7. Verify Regional High Availability and Failover ⚖️

## 🎯 Section Goal
Thoroughly test and validate the functionality of the deployed Azure Load Balancers across both the West US and East US regions. The objective is to ensure that incoming HTTP traffic is evenly distributed among healthy backend instances and to confirm that the architecture gracefully handles simulated server failures without experiencing application downtime.

---

## 🚀 Implementation Steps

### Task 1: Configure Static Private IP Addresses
To ensure routing stability, the private IP addresses of all four backend virtual machines were converted from Dynamic to Static. This prevents the IPs from changing upon VM reboots, which would otherwise disrupt the load balancer's backend pool configuration.
* Navigated to **Network interfaces** in the Azure Portal and selected the active NIC for each virtual machine.
* Accessed **IP configurations** > `ipconfig1` and updated the allocation assignment to **Static**.

*(Evidence)*
![Navigate to NICs](images/1%20-%20Configure%20Static%20IP%20VMs%20on%20Addresses%201.png)
![Set Static IP](images/1%20-%20Configure%20Static%20IP%20VMs%20on%20Addresses%203.png)

---

### Task 2: Deploy Custom Health/Test Pages
To visually verify which backend VM is serving a given request, the default IIS welcome page on every server was replaced with a custom HTML file displaying the server's unique hostname.
* Utilized the Azure **Run Command** feature to remotely execute the following PowerShell script on all VMs across both regions:
  ```powershell
  Set-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value $env:computername
  ```
* Verified that the script executed successfully, updating the web root contents securely without requiring direct RDP access.

---

### Task 3: Load Balancing & Failover Validation (West US)

**1. Initial Traffic Routing Validation:**
* Accessed the frontend Public IP of `LB-West` (`52.234.7.174`) via a web browser.
* The load balancer successfully routed the HTTP request to an active backend instance, correctly rendering `WEST01` on the screen.

**2. High Availability / Failover Simulation:**
* Intentionally **Stopped (deallocated)** the active `WEST01` virtual machine via the Azure Portal to simulate a critical zone/hardware failure.
* Refreshed the web browser targeting the same Load Balancer IP.
* **Result:** The load balancer immediately detected the unhealthy probe, removed `WEST01` from the rotation, and redirected traffic to the secondary healthy instance, seamlessly displaying `WestUS02`.

---

### Task 4: Load Balancing & Failover Validation (East US)

An identical validation matrix was executed against the East US infrastructure to guarantee multi-region consistency:

**1. Initial Traffic Routing Validation:**
* Accessed the frontend Public IP of `LB-East` (`20.106.157.177`).
* Traffic was successfully distributed, with the initial response served by `EAST01`.

**2. High Availability / Failover Simulation:**
* Intentionally stopped the active `EAST01` virtual machine.
* Refreshed the browser session targeting `20.106.157.177`.
* **Result:** The failover mechanism executed flawlessly, instantly routing traffic to the healthy `EastUS02` node.

*(East US Validation Evidence)*
![LB-East IP](images/4%20-%20same%20validation%20in%20East%201.png)
![EAST01 Active](images/4%20-%20same%20validation%20in%20East%20%202.png)
![Failover to EastUS02](images/4%20-%20same%20validation%20in%20East%20%203.png)

---
*✅ Phase 7 Completed Successfully! The regional High Availability setup is fully validated and proven resilient in BOTH the West and East regions.*