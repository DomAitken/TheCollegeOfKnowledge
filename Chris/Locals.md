# Locals
- Locals are values that are computed inside the configuration.
- They are like functions in programming languages. 

## Syntax
---
Local values are assigned within a locals block
```
locals {
    key = "value"
    other_key = {
        key1 = "value1"
        key2 = "value2"
    }
}

locals = {
    instance_prefix = "globo"
    common_tags = {
        company = "Globomantics"
        project = var.project
    }
}
```

## Referencing 
---
How to reference a local value
```
local.<name_label>

local.instance_prefix

local.common_tags.company
```

## Data Structures
---
Locals can be used to create data structures that enable nested for loops to be used for creating multiple resources. <br />

[Reference](https://www.daveperrett.com/articles/2021/08/19/nested-for-each-with-terraform/)

The below *'traffic_schema'* uses a nested-for-loop and the *'type'* and *'ports'* locals to create a data structure that is then used to loop through and create multiple resources within one resource block.
```
traffic_type = [
    "ingress",
    "egress"
]
traffic_ports = [
    80,
    443,
    8090,
    5801
]

traffic_schema = flatten([
    for type in local.traffic_type : [
      for port in local.traffic_ports : {
        type = type
        port = port
      }
    ]
])
```
Data Structure that it creates: 
```
{
          + port = 80
          + type = "ingress"
        },
      + {
          + port = 443
          + type = "ingress"
        },
      + {
          + port = 8090
          + type = "ingress"
        },
      + {
          + port = 5801
          + type = "ingress"
        },
      + {
          + port = 80
          + type = "egress"
        },
      + {
          + port = 443
          + type = "egress"
        },
      + {
          + port = 8090
          + type = "egress"
        },
      + {
          + port = 5801
          + type = "egress"
        },
```

Resource block that loops through the above *'traffic_schema'* to create multiple resources from the two lists of values.
Creates a resource of each type and of each port. As illustrated in the above code block.
```
resource "aws_security_group_rule" "dev_box" {
  for_each                 = { for entry in local.traffic_schema : "${entry.type}.${entry.port}" => entry }
  type                     = each.value.type
  from_port                = each.value.port
  to_port                  = each.value.port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.dev_box_lb.id
  security_group_id        = aws_security_group.dev_box.id
}
```

## Combining Lists
---
- Locales can be used to combine two lists into one

Var.test and var.test2 are two lists that are combined into a new list of objects called local.test2. Each value of the lists are matched based on the index of their initial lists. <br />
E.g. value of var.test[0] is matched with the value of var.test2[0] and so on.

```
test2 = [
    for t2 in var.test2 : {
      name = t2
      key  = var.test[(index(var.test2, t2))]
    }
  ]
```
Data structure that is produced
```
 test = [
      + {
          + key  = "ports"
          + name = 80
        },
      + {
          + key  = "protocol"
          + name = "tcp"
        },
      + {
          + key  = "active"
          + name = true
        },
    ]
```