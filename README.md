# Terraform EKS VPC Setup

This repository provides a Terraform configuration to create an EKS cluster inside a custom VPC on AWS. It includes network setup (VPC, subnets, route tables), security groups, and necessary configurations for deploying and managing the infrastructure.

## Prerequisites

- AWS account
- Terraform installed
- IAM credentials with appropriate permissions

## File Structure

1. **versions.tf**
   - This file declares the necessary providers and their versions.
   - It ensures that the correct version of Terraform and AWS provider is used to avoid compatibility issues.
   
2. **variables.tf**
   - This file defines all the input variables used across the configuration.
   - Variables like VPC CIDR blocks, availability zones, and resource names are defined here.
   
3. **vpc.tf**
   - This file contains the configuration to create a Virtual Private Cloud (VPC), public and private subnets, route tables, and internet gateway.
   - It establishes the network infrastructure in which the EKS cluster will reside.
   
4. **security-groups.tf**
   - This file configures security groups that define ingress (inbound) and egress (outbound) rules for EC2 instances.
   - It specifies allowed ports, protocols, and CIDR blocks for both inbound and outbound traffic.

5. **outputs.tf**
   - This file defines the outputs that display essential information about the resources created.
   - Information such as VPC ID, subnet IDs, and security group IDs will be displayed after applying Terraform.

6. **eks.tf**
   - This file sets up the EKS cluster within the previously created VPC.
   - It configures node groups, IAM roles, and integrates the VPC subnets with the EKS cluster.

## Setup Instructions

1. **Define Versions and Providers:**
   - Start by configuring the `versions.tf` file to declare the provider versions.

2. **Configure Variables:**
   - Define the necessary variables in `variables.tf`. You can override these variables by providing a `.tfvars` file or passing them directly during `terraform apply`.

3. **Create the VPC:**
   - Run the `vpc.tf` file to create the custom VPC, subnets, route tables, and internet gateway.

4. **Set Up Security Groups:**
   - Apply the `security-groups.tf` file to define the necessary security groups for the resources in the VPC.

5. **Deploy EKS:**
   - Use the `eks.tf` file to create an EKS cluster using the previously created network infrastructure.
   - Ensure that all VPC subnets are appropriately tagged for the EKS cluster.

6. **Check Outputs:**
   - Review the outputs from `outputs.tf` after the infrastructure has been deployed. These outputs provide important IDs and information for future configuration.

## Apply the Configuration

Run the following commands in sequence:

```bash
terraform init
terraform plan
terraform apply
```
## create access entry

create the entry access for desired IAM user so that the worker nodes get started
go to `create access entry` and grant the user `AmazonEKSClusterAdminPolicy` permission and create the access entry