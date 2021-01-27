module "satellite-host" {
  source            = "../../modules/host"
  
  module_depends_on = module.ec2
  ip_count          = 3
  host_vm           = module.ec2.private_dns
  location_name     = var.location_name
  host_zone         = var.ibm_region
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
}