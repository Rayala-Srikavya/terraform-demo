terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 0.50"
    }
  }
}

# Define variables for dynamic input
variable "account_name" {}
variable "organization_name" {}
variable "database" {}
variable "schema" {}

provider "snowflake" {
  account_name     = var.account_name
  organization_name = var.organization_name
  host             = "RCNZCWF-UU37435.snowflakecomputing.com"
}

# Read JSON file dynamically
locals {
  table_config = jsondecode(file("${path.module}/snowflake-table.json"))
}

# Creating tables dynamically from JSON configuration
resource "snowflake_table" "tables" {
  database = var.database
  schema   = var.schema
  name     = local.table_config.snowflake.tables[0].name

  dynamic "column" {
    for_each = local.table_config.snowflake.tables[0].columns
    content {
      name = column.value.name
      type = column.value.type
    }
  }
}
