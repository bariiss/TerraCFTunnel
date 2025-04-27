terraform {
  required_version = ">= 1.5"
  required_providers {
    cloudflare = { source = "cloudflare/cloudflare", version = ">= 5.3" }
    random     = { source = "hashicorp/random",      version = ">= 3.5" }
    local      = { source = "hashicorp/local",       version = ">= 2.4" }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}