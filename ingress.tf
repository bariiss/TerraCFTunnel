resource "cloudflare_zero_trust_tunnel_cloudflared_config" "main" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.main.id

  config = {
    ingress = flatten([
      [for service in var.services : {
        hostname = service.hostname
        service  = service.target
        zone_id  = service.zone_id
      }],
      [{
        service = "http_status:404"
      }]
    ])
  }
}