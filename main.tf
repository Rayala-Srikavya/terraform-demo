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
