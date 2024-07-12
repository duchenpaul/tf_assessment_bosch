# Terraform Azure VM Deployment

## Overview
This Terraform configuration deploys a configurable number of VMs in Azure, sets up network connectivity, and performs a round-robin ping test between the VMs.

## Usage

### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) installed
- Azure CLI installed and authenticated

### Variables
- `tenant_id`: Tenant ID of the Azure account.
- `owner_details`: Owner details of the Azure account.
- `private_key_path`: Private key path of the user to connect to the VMs.
- `vnet_use_existing`: if set `true`, it will use the existing VNet, otherwise it will create a new VNet.
- `resource_group_name`: Name of the resource group.
- `location`: Azure region for deployment.
- `vm_count`: Number of VMs to create.
- `vm_size`: VM size.
- `vm_image`: VM image.
- `admin_username`: Admin username for VMs.


### Commands
Initialize the Terraform configuration:

```sh
terraform init
```

Plan the deployment:

```sh
terraform plan
```

Apply the configuration:

```sh
terraform apply
```

### Outputs
The ping results will be displayed as a Terraform output after the apply step. See [sample output](sample_output.txt)

## Cleanup
To destroy the

 created resources:

```sh
terraform destroy
```

