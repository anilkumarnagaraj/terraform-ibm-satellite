
#################################################################################################
# IBMCLOUD & AWS -  Authentication , Target Variables.
# The region variable is common across zones used to setup VSI Infrastructure and Satellite host.
#################################################################################################

variable "ibmcloud_api_key" {
  description  = "IBM Cloud API Key"
  type         = string
}

variable "aws_access_key" {
  description  = "AWS access key"
  type         = string
}

variable "aws_secret_key" {
  description  = "AWS secret key"
  type         = string
}

variable "ibm_region" {
  description = "Region of the IBM Cloud account. Currently supported regions for satellite are `us-east` and `eu-gb` region."
  default     = "us-east"

  validation {
    condition     = var.ibm_region == "us-east" || var.ibm_region == "eu-gb"
    error_message = "Sorry, satellite only accepts us-east or eu-gb region."
  }
}

variable "aws_region" {
  description  = "AWS region"
  type         = string
  default      = "us-east-1"
}

variable "resource_group" {
  description = "Name of the resource group on which location has to be created"
  type        = string
  default     = "Default"
}

##################################################
# IBMCLOUD Satellite Location Variables
##################################################

variable "location_name" {
  description = "Location Name"

  validation {
    condition     = var.location_name != ""
    error_message = "Sorry, please provide value for location_name variable."
  }
}

variable "location_label" {
  description = "Label to create location"
  default     = "prod=true"
}

variable "cluster_name" {
  description = "Satellite cluster name"
  default     = "satellite-cluster"
}

##################################################
# AWS EC2 Variables
##################################################
variable "host_count" {
  description    = "The total number of aws host to create for control plane. host_count value should always be in multiples of 3, such as 3, 6, 9, or 12 hosts"
  type           = number
  default        = 3

  validation {
    condition     = (var.host_count % 3) == 0 &&  var.host_count > 0
    error_message = "Sorry, host_count value should always be in multiples of 3, such as 6, 9, or 12 hosts."
  }
}

variable "instance_type" {
  description    = "The type of aws instance to start, satellite only accepts `m5d.2xlarge` or `m5d.4xlarge` as instance type."
  type           = string
  default        = "m5d.2xlarge"

  validation {
    condition     = var.instance_type == "m5d.2xlarge" || var.instance_type == "m5d.4xlarge"
    error_message = "Sorry, satellite only accepts m5d.2xlarge or m5d.4xlarge as instance type."
  }
}

variable "ssh_public_key" {
  description = "SSH Public Key. Get your ssh key by running `ssh-key-gen` command"
  type        = string

  validation {
    condition     = var.ssh_public_key != ""
    error_message = "Sorry, please provide value for ssh_public_key variable."
  }
}

variable "vm_prefix" {
  description = "Name to be used on all aws resource as prefix"
  type        = string
  default     = "satellite-aws-tf"
}