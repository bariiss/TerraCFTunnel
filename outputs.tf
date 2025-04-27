data "cloudflare_zero_trust_tunnel_cloudflared_token" "main" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.main.id
}

output "cloudflared_command" {
  value       = "cloudflared tunnel run --token ${data.cloudflare_zero_trust_tunnel_cloudflared_token.main.token}"
  sensitive   = true
  description = "Command to run cloudflared tunnel with the generated token"
}

output "tunnel_id" {
  value       = cloudflare_zero_trust_tunnel_cloudflared.main.id
  description = "ID of the Cloudflare tunnel"
}

output "tunnel_name" {
  value       = cloudflare_zero_trust_tunnel_cloudflared.main.name
  description = "Name of the Cloudflare tunnel"
}