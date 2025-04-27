variable "account_id" { type = string }

variable "services" {
  description = "Map of services to expose through the tunnel"
  type = map(object({
    hostname = string
    target   = string
    zone_id  = string
  }))
}

variable "api_token" {
  description = "Cloudflare API token with the necessary permissions"
  type        = string
  sensitive   = true
}

variable "tunnel_name" {
  description = "Name of the Cloudflare Tunnel"
  type        = string
}