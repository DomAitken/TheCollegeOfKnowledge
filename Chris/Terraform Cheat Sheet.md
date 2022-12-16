# Useful Links 
Terraform docs: https://registry.terraform.io/

## Block Syntax
---
Terraform uses block syntax
```
block_type "label" "name_label" {
    key = "value"
    nested_block {
        key = "value"
    }
}

resource "aws_instance" "web_server" {
    name = "web_server"
    ebs_volume {
        size = 40
    }
}
```

How to reference an object in Terraform
```
<resource_type>.<name_label>.<attribute>

aws_instance.web_server.name
```
## Basic Commands
---
Initializes a directory for Terraform <br />
```
terraform init
```

Format Terraform files <br />
```
terraform fmt
```

Checks if the Terraform code is valid <br />
```
terraform validate
```

Creates a plan for the .tf files and creates a m3.tfplan file and saves the output to it <br />
```
terraform plan -out m3.tfplan
```

Runs the plan that is saved in the m3.tfplan file <br />
```
terraform apply "m3.tfplan"
```

Tears down resources in created in the directory <br />
```
terraform destroy
```

## Variable Syntax
---
- ***variables.tf*** file is used to declare empty variables. <br />
***terraform.tfvars*** file is used to add values to variables declared in ***variables.tf*** file. <br />

Declare an empty variable. <br />
```
variable "name_label" {}
``` 

Declaring a variables: type, description, default (value) and sensitivity.
```
variable "name_label" {      
    type = value                        
    description = "value"    
    default = "value"                     
    sensitive = true | false              
}      
```                      

How to reference variables. <br />
```
var.<name_label>    

var.aws_region
```

How to reference variables in a map. <br />
```
var.<name_label>["value_key"]

var.subnets_cidr["public_subnets_cidr"]
```

## Primitive Data Types for
---
**String**
```
"us-west-1"
```

**Number** (integer or decimal)
```
6 

0.5
``` 
**Boolean**
```
true

false
```

## Collection Data Types
---
- Groupings of the primitive data types and must be of the same data type.

**List** (ordered group of elements) 
```
[1, 2, 3, 4]

["eu-west-1", "eu-west-2", "eu-west-3"]
```

**Map** (group of key value pairs) 
```
{
    small  = "t2.micro"
    medium = "t2.small"
    large  = "t2.large"
}
```

**Set** (set of unique values and can use *toset()* function to cast a list to a set. Useful when trying to use *for_each* loops)
```
variable "users_set" {
  type = set(string)
  default = (["root", "user1", "user2"])
}
```

How to reference collection values.
```
var.<name_label>[<element_number>]

var.aws_regions[1]

var.aws_instance_size["medium"]
```

## Structural Data Types
---
- Allows data types stored in each grouping to be mixed. 

**Tuple** (equivalent to lists)
```
person1 = [4, "James", true]
```
**Objects** (equivalent to maps)
```
person1 = {
    name       = "James"
    experience = 4
    retired    = true
}
```

## Output
--- 
- Values printed out to the terminal window after a configuration is run.

Output syntax
```
output "name_label" {
    value       = output_value
    description = "Description of the output."
    sensitive   = true | false
}

output "public_dns_hostname" {
    value       = aws_instance.web_server.public_dns
    description = "Public DNS hostname web server."
}
```

## Data Sources
---
- Data sources allow Terraform to use information defined outisde of Terraform, defined by other Terraform configuration or modified by functions. 

Data block syntax
```
data "<instance_type>" "name_label" {
    filter {
        name  = <attribute_name>
        value = <attribute_value>
    }
}

data "aws_subnets" "sub_test" {
  filter {
    name   = "vpc-id"
    values = ["vpc-03bd721528c7911c4"]
  }
}
```

Referencing a data source
```
data.<resource_type>.<name_label>.<attribute>

output "subnet_output" {
    value = data.aws_subnets.sub_test
}
```
