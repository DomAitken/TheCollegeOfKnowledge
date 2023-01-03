# Import

- Terraform can import existing infrastructure into the state and thus be managed by Terraform. 
- An empty resource block, of the type you wish to import, must be written before importing.

```
resource "aws_subnet" "subnet-a" {

}
```

## Import command
- The import command for each resource type can be found at the bottom of the resource page of the Terraform documentation (different command format for each resource type).
```
terraform import <resource_type>.<name_label> <id/arn>

terraform import aws_subnet_public_subnet subnet-9f4r7y6c
```

## Terraform Show 
---
Once the resource has been imported into the state, the show command can display the resource in Terraform's block syntax.
```
terraform show
```