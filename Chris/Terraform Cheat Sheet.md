# Useful Links 
*Terraform docs: https://registry.terraform.io/*

# Info
*Create a declarative Terraform file .tf that specifies the provider and resources etc.*
*Terraform files are written in JSON or HashiCorp Configuration Language, HCL*


# Basic Commands

`terraform init`                          *Initializes a directory for Terraform*
`terraform plan -out m3.tfplan`           *Creates a plan for the .tf file and creates a m3.tfplan file and saves the output to it*
`terraform apply "m3.tfplan"`             *Runs the plan that is saved in the m3.tfplan file* 
`terraform destroy`                       *Tears down running resources in created in the directory*


-------------------------------------------------------------------------------------------------------------------------------------------------------


# State Commands 
`terraform state list`                                              *Lists all state resources* 

`terraform state show <resource address>`                           *Shows a specific resource, address is the resource type and name_label*

`terraform state mv <source address> <destination address>`         *Move an item in state*

`terraform state rm <address>`                                      *Remove an item from state* 


-------------------------------------------------------------------------------------------------------------------------------------------------------


# Variable Syntax

`variable "name_label" {} `

`variable "name_label" {      `
`    type = value             `               *type refers to the data type*
`    description = "value"    `
`    default = "value"        `               *A default value for the variable if ones is not submitted*
`    sensitive = true | false `               *Used to hide sensitive values, they're not displayed in logs*
`}                            `

`var.<name_label>`                            *Terraform Variable Reference*
`var.aws_region`

# Primitive Data Types for
*String, number (integer or decimal) and boolean*

# Collection Data Types
*List (ordered), set (unordered) and map (group of key value pairs). Groupings of the primitive data types and must be of the same type.*

# Structural Data Types
*Tuple (equivalent to lists) and Objects (equivalent to maps). Allows data types stored in each grouping to be mixed*

# Locales Syntax
`locals {               `
`    key = value        `
`}                      `

`locals {                                   `
`    instance_prefix = globo                `
`    common_tags = {                        `
`       company = "globomantics"            `
`       project = var.project               `
`       billing_code = var.billing_code     `
`    }                                      `
`}                                          `

# Locals Reference
`local.<name_label>`
`local.instance_prefix`
`local.common_tags.company`

# Output 
`output "label_name" {                          `
`    value = output_value                       `
`    description = "description of output"      `
`    sensitive = true | false                   `
`}                                              `

# Terraform validate
`terraform validate`                *Checks files for any errors, must have done `terraform init` first*