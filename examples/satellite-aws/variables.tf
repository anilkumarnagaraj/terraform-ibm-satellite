
##################################################
# IBMCLOUD Satellite Location Variables
##################################################

variable "location_name" {
    description  =  "Name of the satellite location on which cluster has to be created | attached"
}

variable "location_zone" {
  description  = "zone of the staellite location"
  default      = "wdc06"
}

variable "label" {
  description  =  "Host labels"
  default      =  "env=dev"
}

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

variable "aws_region" {
  description  = "AWS region"
  type         = string
}

variable "region" {
  description = "Location Region"
  type        = string
  default     = "us-south"
}

variable "resource_group" {
  description = "Resoure Group"
  type        = string
  default     = "default"
}

##################################################
# AWS EC2 Variables
##################################################

variable "vm_prefix" {
  description = "Name to be used on all VMs as prefix"
  type        = string
  default     = "aws-satellite-ec2"
}

variable "key_name" {
  description  = "Number of instances to launch"
  type         = string
  default      = "aws_ssh_key"
}

variable "ssh_public_key" {
  description  = "SSH public key"
  type         = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 3
}