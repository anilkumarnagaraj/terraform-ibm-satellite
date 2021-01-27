# satellite-aws

Use this terrafrom automation to set up satellite location on IBM cloud with AWS host.

This example cover end-to-end functionality of IBM cloud satellite by creating satellite location on specified zone. 
It will provision 4 AWS host and assign 3 AWS host to location control plane and one AWS host to satellite cluster.

#### Example uses below 5 terraform modules to set up the satellite on AWS:

1. [satellite-location](../../modules/location) This module `creates satellite location` for the specified zone|location|region and `generates script` named addhost.sh in the working directory.
2. [ec2](instance.tf) This module will provision AWS EC2 instance and use the generated script in module as `user_data` and runs the script. At this stage all the VMs that has run addhost.sh will be attached to the satellite location and will be in unassigned state.
3. [satellite-host](../../modules/host) This module assigns 3 aws hosts to the location control plane.
4. [satellite-cluster](../../modules/cluster) This module will create satellite cluster.
5. [satellite-cluster-host](../../modules/cluster_host) This module will assign aws host to satellite cluster.

## Compatibility

This module is meant for use with Terraform 0.13 or later. 

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.13 or later. 
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm) 

## Install

### IBM Cloud CLI

Be sure you have installed IBM Cloud plug-in for Satellite
- https://cloud.ibm.com/docs/satellite?topic=satellite-setup-cli

### Terraform

Be sure you have the correct Terraform version ( 0.13 or later), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform provider plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm) 
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
  instance_count              = 4
  name                        = "${var.vm_prefix}-host"
  use_num_suffix              = true
  ami                         = data.aws_ami.redhat_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.keypair.key_name
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  placement_group             = aws_placement_group.web.id
  user_data                   = file(replace("${path.module}/addhost.sh*${module.satellite-location.module_id}", "/[*].*/", ""))
 
  tags = {
    "Name"  = "${var.vm_prefix}-host"
  }

}

module "satellite-host" {
  source            = "../../modules/host"
  
  module_depends_on = module.ec2
  host_count        = var.host_count
  host_vm           = module.ec2.private_dns
  location_name     = var.location_name
  ibmcloud_api_key  = var.ibmcloud_api_key
  ibm_region        = var.ibm_region
  endpoint          = "cloud.ibm.com"
  resource_group    = var.resource_group
  host_provider     = "aws"
}

...
...
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                                  | Description                                                       | Type     | Default | Required |
|---------------------------------------|-------------------------------------------------------------------|----------|---------|----------|
| ibmcloud_api_key                      | IBM Cloud API Key                                                 | string   | n/a     | yes      |
| ibm_region                            | IBM cloud region                                                  | string   | us-east | yes      |
| resource_group                        | Resource Group Name that has to be targeted                       | string   | Default | yes      |
| aws_access_key                        | AWS access key                                                    | string   | n/a     | yes      |
| aws_secret_key                        | AWS secret key                                                    | string   | n/a     | yes      |
| aws_region                            | AWS cloud region                                                  | string   | n/a     | yes      |
| location_name                         | Name of the Location that has to be created                       | string   | satellite-aws     | yes |
| location_labels                       | Label to create location                                          | string   | env=dev |  yes     |
| vm_prefix                             | Name to be used on all resources as prefix                        | string   | satellite-aws     | yes |
| instance_type                         | The type of aws instance to start                                 | string   | m5d.2xlarge     | yes |
| cluster_name                          | Name of the satellite cluster                                     | string   | satellite-cluster     | yes |


## Outputs

| Name | Description |
|------|-------------|
| satellite_location | satellite location value |
| module_id | satellite-location module ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Note

* Satellite Location module download attach host script in the current directory and * appends respective permissions to the script..The modified script must be used in the `user_data` attribute of ec2 module.