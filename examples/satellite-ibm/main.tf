module "satellite-location" {
  source            = "../../modules/location"
  location_zone     = var.location_zone
  location_name     = var.location_name
  location_label    = var.location_label
  host_provider     = "ibm"
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  resource_group    = var.resource_group
  endpoint          = "cloud.ibm.com"
}

module "satellite-host" {
  source            = "../../modules/host"
  module_depends_on = ibm_is_instance.satellite_instance
  ip_count          = 3
  host_vm           = ibm_is_instance.satellite_instance[*].name
  location_name     = var.location_name
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
}
