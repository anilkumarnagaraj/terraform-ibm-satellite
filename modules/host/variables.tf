
#################################################################################################
# IBMCLOUD -  satellite variables
#################################################################################################

variable "location_name" {
  description = "Satellite Location Name"
  type         = string
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
    description  = "The cloud provider of host/vms"
    type         = string
    default      = "aws"
}

variable "host_zone" {
    type         = string
    default      = "us-east"
}

variable "endpoint" {
    description  = "Endpoint of production/stage environment of IBM Cloud "
    type         = string
    default      = "us-east"
}

variable "host_vm" {
}

variable "ip_count" { 
}

variable "module_depends_on" {
}
