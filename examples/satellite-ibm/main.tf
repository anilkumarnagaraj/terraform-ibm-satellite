module "satellite-location" {
  source            = "../../modules/location"

  is_location_exist   = var.is_location_exist
  location            = var.location
  managed_from        = var.managed_from
  location_zones      = var.location_zones
  host_labels         = var.host_labels
  ibmcloud_api_key    = var.ibmcloud_api_key
  ibm_region          = var.ibm_region
  resource_group      = var.resource_group 
  host_provider       = "ibm"
}