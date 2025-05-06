terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.50"
    }
  }
}

provider "snowflake" {
  account  = "RCNZCWF-UU37435"  
  username = "Srikavya"    
  password = "Srpu@7330691779"   
}

resource "snowflake_table" "customers" {
  database = "DEMO_DB"
  schema   = "PUBLIC"
  name     = "customers"

  column {
    name     = "customer_id"
    type     = "INTEGER"
    nullable = false
  }

  column {
    name     = "customer_name"
    type     = "STRING"
    nullable = true
  }

  column {
    name     = "email"
    type     = "STRING"
    nullable = true
  }

  column {
    name     = "created_at"
    type     = "TIMESTAMP"
    nullable = true
  }
}
