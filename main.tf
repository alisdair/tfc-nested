terraform {
  required_providers {
    nested = {
      source = "alisdair/nested"
    }
  }
}

variable "values_json" {
  type = string
  default = <<EOF
  [
    { "string": "foo", "number": 1, "bool": true },
    { "string": "bar", "number": 2, "bool": false, "sensitive": "honk" },
    { "string": "baz", "number": 3, "bool": false }
  ]
EOF
}

locals {
  values = jsondecode(var.values_json)
  values_map = { for v in local.values: v.string => v }
}

resource "nested_list" "example" {
  name = "example"
  values = local.values
}

resource "nested_set" "example" {
  name = "example"
  values = local.values
}

resource "nested_map" "example" {
  name = "example"
  values = local.values_map
}

resource "nested_single" "example" {
  name = "example"
  value = local.values[0]
}
