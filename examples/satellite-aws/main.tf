
module "satellite-location" {
  source            = "../../modules/location"

  location_name     = var.location_name
  location_label    = var.location_label
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
}


module "satellite-host" {
  source            = "../../modules/host"
  
  depends_on        = [ module.ec2 ]
  host_count        = var.satellite_host_count
  host_vms          = module.ec2.private_dns
  location_name     = var.location_name
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
}


resource "null_resource" "status" {
  depends_on = [ module.satellite-host ]

  provisioner "local-exec" {
    command = <<EOT
      echo "Satellite location is still getting normal. Please wait for another 40 mins to complete!!!!!!!!!"
      exit 0
    EOT
  }
}
