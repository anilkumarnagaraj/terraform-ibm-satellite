# satellite-aws

Use this to set up satellite on AWS with EC2 Instances, using Terraform.

This example uses three terraform modules to set up the control plane.

1. [satellite-location.](../modules/location) This module `creates satellite location` for the specified zone|location|region and `generates script` named addhost.sh in the working directory.
2. [ec2](instance.tf) This module will provision AWS EC2 instance and use the generated script in module as `user_data` and runs the script. At this stage all the VMs that has run addhost.sh will be attached to the satellite location and will be in unassigned state.
3. [satellite-host](../modules/host) This module assigns 3 hosts to the location control plane.
4. [satellite-cluster](../modules/cluster) This module will create satellite cluster.

## Prerequisite

* Install Terraform 0.13 or later.
* Set up the IBM Cloud command line interface (CLI), the Satellite plug-in, and other related CLIs.
* Install cli and plugin package
```console
    ibmcloud plugin install container-service
```
* Follow the Host [requirements](https://cloud.ibm.com/docs/satellite?topic=satellite-host-reqs) 
## Usage

```
terraform init
```
```
terraform plan
```
```
terraform apply
```
```
terraform destroy
```
## Example Usage
``` hcl
module "satellite-location" {
  source            = "../../modules/location"

  location          = var.location_name
  zone              = var.location_zone
  label             = var.location_label
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
}

module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  
  depends_on                  = [ module.satellite-location ]
  instance_count              = var.instance_count
  name                        = var.vm_prefix
  ami                         = "ami-065ec1e661d619058"
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.keypair.key_name
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  placement_group             = aws_placement_group.web.id
  user_data                   = file(replace("${path.module}/addhost.sh*${module.satellite-location.module_id}", "/[*].*/", ""))
 
  tags = {
    "Name"  = "aws"
  }

}

module "satellite-host" {
  source            = "../../modules/host"
  
  module_depends_on = module.ec2
  ip_count          = 3
  host_vm           = module.ec2.private_dns
  location          = var.location_name
  host_zone         = var.ibm_region
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                                  | Description                                                       | Type     | Default | Required |
|---------------------------------------|-------------------------------------------------------------------|----------|---------|----------|
| ibmcloud_api_key                      | IBM Cloud API Key                                                 | string   | n/a     | yes      |
| aws_access_key                        | AWS access key                                                    | string   | n/a     | yes      |
| aws_secret_key                        | AWS secret key                                                    | string   | n/a     | yes      |
| aws_region                            | AWS cloud region                                                        | string   | n/a     | yes      |
| ibm_region                            | IBM cloud region                                                  | string   | us-east     | yes      |
| resource_group                        | Resource Group Name that has to be targeted                       | string   | default     | yes      |
| endpoint                              | Endpoint of production/stage environment of IBM Cloud             | string   | cloud.ibm.com     | yes      |
| location_name                         | Name of the Location that has to be created                       | string   | n/a     | yes      |
| location_zone                         | Zone in which satellite location has to be created. Ex:wdc06      | string   | wdc06    | yes      |
| location_labels                       | Label to create location                                          | string   | env=dev |  yes     |
| vm_prefix                             | Name to be used on all resources as prefix                        | string   | sat     | yes      |
| instance_type                         | The type of aws instance to start                                 | string   | m5d.2xlarge     | yes      |
| cluster_name                          | Name of the satellite cluster                                     | string   | n/a     | yes      |