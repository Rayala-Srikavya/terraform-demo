terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.50"
    }
    yaml = {
      source  = "ashald/yaml"
      version = "0.2.0"
    }
  }
}

provider "snowflake" {
  account  = "RCNZCWF-UU37435"   
  username = "Srikavya"          
  password = "Srpu@7330691779"   
}

# Loading YAML file
data "yaml_file" "tables" {
  input = file("${path.module}/snowflake-table.yaml")
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
