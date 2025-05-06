terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 0.50"
    }
  }
}

provider "snowflake" {
  account  = "RCNZCWF-UU37435"   
  username = "Srikavya"          
  password = "Srpu@7330691779"   
}

# Read YAML file as raw content
locals {
  yaml_content = file("${path.module}/snowflake-table.yaml")
}

# Creating tables dynamically from YAML configuration
resource "snowflake_table" "tables" {
  database = data.yaml_file.tables.snowflake.database
  schema   = data.yaml_file.tables.snowflake.schema
  name     = data.yaml_file.tables.snowflake.tables[0].name

  dynamic "column" {
    for_each = data.yaml_file.tables.snowflake.tables[0].columns
    content {
      name = column.value.name
      type = column.value.type
    }
  }
}
