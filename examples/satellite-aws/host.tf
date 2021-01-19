module "satellite-host" {
  source            = "../../modules/host"
  module_depends_on = module.ec2
  ip_count          = 1
  host_vm           = module.ec2.private_dns
  location          = var.location_name
  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = var.region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
}