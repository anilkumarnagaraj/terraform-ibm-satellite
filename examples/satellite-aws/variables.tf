
##################################################
# IBMCLOUD Satellite Location Variables
##################################################

variable "location_name" {
  description = "Location Name"
  default     = "satellite-aws"
}

variable "location_zone" {
  description = "zone of the satellite location. Currently available in washing DC and London Zones."
  default     = "wdc06"
}

variable "location_label" {
  description = "Label to create location"
  default     = "prod=true"
}

#################################################################################################
# IBMCLOUD & AWS -  Authentication , Target Variables.
# The region variable is common across zones used to setup VSI Infrastructure and Satellite host.
#################################################################################################

variable "ibmcloud_api_key" { 
  description  = "IBM Cloud API Key"
  type         = string
}

variable "aws_region" {
  description  = "AWS region"
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

variable "resource_group" {
  description = "Name of the resource group on which location has to be created"
  type        = string
  default     = "Default"
}

variable "ibm_region" {
  description = "Region of the IBM Cloud account"
  default     = "us-east"
}

##################################################
# AWS EC2 Variables
##################################################
variable "instance_type" {
  description    = "The type of aws instance to start"
  type           = string
  default        = "m5d.2xlarge"

  validation {
    condition     = var.instance_type == "m5d.2xlarge" || var.instance_type == "m5d.4xlarge"
    error_message = "Sorry, satellite only accepts m5d.2xlarge or m5d.4xlarge as instance type."
  }
}

variable "vm_prefix" {
  description = "Name to be used on all VMs as prefix"
  type        = string
  default     = "aws-satellite-ec2"
}

variable "ssh_public_key" {
  description = "SSH Public Key. Get your ssh key by running `ssh-key-gen` command"
  type        = string
}

##################################################
# Satellite cluster
##################################################
variable "cluster_name" {
  description = "Satellite cluster name"
  default     = "satellite-cluster-01"
}