
##################################################
# IBMCLOUD Satellite Location Variables
##################################################

variable "location_name" {
  description = "Location Name"
  type         = string
}

variable "location_zone" {
  description = "zone of the satellite location. Currently available in washing DC and London Zones."
  type         = string
  default     = "wdc06"
}

variable "location_label" {
  description = "Label to add to attach host script"
  type         = string
  default     = "prod=true"
}

#################################################################################################
# IBMCLOUD -  Authentication , Target Variables.
#################################################################################################

variable "ibmcloud_api_key" {
  description  = "IBM Cloud API Key"
  type         = string
}

variable "resource_group" {
  description = "Name of the resource group on which location has to be created"
  type        = string
  default     = "Default"
}

variable "ibm_region" {
  description = "Region of the IBM Cloud account"
  type         = string
  default     = "us-east"
}

variable "host_provider" {
    description  = "The cloud provider of host|vms"
    type         = string
    default      = "aws"
}

variable "endpoint" {
    description  = "Endpoint of production/stage environment of IBM Cloud "
    type         = string
    default      = "cloud.ibm.com"
}