output "lb_backend_pool_ids" {
  description = "Backend pool IDs for the Load Balancers in each region."
  value = {
    for k, lb in module.load_balancers : k => lb.backend_pool_id
  }
}

output "lb_public_ip_fqdns" {
  description = "Public IP FQDNs for the Load Balancers in each region."
  value = {
    for k, lb in module.load_balancers : k => lb.public_ip_fqdn
  }
}

output "traffic_manager_fqdn" {
  description = "Global Traffic Manager DNS name."
  value       = module.traffic_manager.fqdn
}
