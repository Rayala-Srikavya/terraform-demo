terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 0.50"
    }
  }
}

# Define variables for dynamic input
variable "account" {}
variable "user" {}
variable "password" {}
variable "role" {}
variable "warehouse" {}
variable "database" {}
variable "schema" {}

provider "snowflake" {
  account    = var.account
  user       = var.user
  password   = var.password
  role       = var.role
  warehouse  = var.warehouse
  database   = var.database
  schema     = var.schema
}

# Read JSON file dynamically instead of YAML
locals {
  table_config = jsondecode(file("${path.module}/snowflake-table.json"))
}

# Creating tables dynamically from JSON configuration
resource "snowflake_table" "tables" {
  database = local.table_config.snowflake.database
  schema   = local.table_config.snowflake.schema
  name     = local.table_config.snowflake.tables[0].name

  dynamic "column" {
    for_each = local.table_config.snowflake.tables[0].columns
    content {
      name = column.value.name
      type = column.value.type
    }
  }
}
