# 4. Deploy and Configure Load Balancers ⚖️

## 🎯 Section Goal
Deploy two fully functional public Azure Load Balancers (one in West US, one in East US) to ensure seamless traffic distribution across virtual machines. These load balancers will serve as the primary regional endpoints for an Azure Traffic Manager profile in the final phases of this project.

---

## 📚 Theoretical Concept & Learning Objectives
Azure Load Balancers operate at Layer 4 (TCP/UDP) to distribute incoming traffic among healthy virtual machine instances. 
- **High Availability:** Prevents overloading of any single VM and ensures continuous application availability in case of individual instance failures.
- **Health Probes:** Continuously monitors the health of backend instances (e.g., checking HTTP port 80). Traffic is instantly halted to any instance that fails the health check.
- **Strategic Placement:** Deploying load balancers regionally prepares the infrastructure for global traffic routing using Azure Traffic Manager.

---

## 🚀 Task 1: Deploy `LB-West` (West US Region)

**Implementation Steps:**
1. **Initiate Deployment:** Searched for **Load balancers** in the Azure Portal and created a new Standard Regional Public Load Balancer named `LB-West` within the `RG-lab` resource group in the `West US` region.
2. **Frontend IP:** Created a new public IP address (`FE-LBWese`) to serve as the internet-facing entry point for regional traffic.
3. **Backend Pool:** Configured a backend pool named `BE-pool` and associated it with `vNet-West`. This pool will later host the regional virtual machines.
4. **Health Probes & Rules:** - Created an HTTP health probe (`http-check`) monitoring port 80 with a 5-second interval.
   - Defined a Load Balancing Rule to forward TCP traffic arriving on frontend port 80 to backend port 80.

*(Deployment Evidence)*
![LB-West Basics](images/1%20-%20Deploy%20and%20Configure%20LB-West%20Load%20Balancer2.png)
![LB-West Rules](images/1%20-%20Deploy%20and%20Configure%20LB-West%20Load%20Balancer5.png)

---

## 🚀 Task 2: Deploy `LB-East` (East US Region)

**Implementation Steps:**
1. **Initiate Deployment:** Provisioned the second Standard Public Load Balancer named `LB-East` in the `East US` region for multi-region redundancy.
2. **Frontend IP:** Assigned a new dedicated public IP (`FE-IP`).
3. **Backend Pool:** Created `BE-LBEast` and linked it directly to `vNet-East`.
4. **Health Probes & Rules:** Mirrored the West region configuration by establishing an HTTP health probe and a port 80 load balancing rule to ensure consistent traffic handling across both geographical sites.

*(Deployment Evidence)*
![LB-East Basics](images/2%20-%20Deploy%20and%20Configure%20LB-East%20Load%20Balancer.png)
![LB-East Rules](images/2%20-%20Deploy%20and%20Configure%20LB-East%20Load%20Balancer3.png)

---

## ✅ Final Verification

Successfully validated that both `LB-West` and `LB-East` are fully provisioned, active, and listed in the Azure Load Balancers dashboard, ready to route traffic to the upcoming compute resources.

![Load Balancers Validation](images/validation.png)

---
*✅ Phase 4 Completed Successfully!*