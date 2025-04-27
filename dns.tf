resource "cloudflare_dns_record" "cname" {
  for_each = var.services

  zone_id = each.value.zone_id
  name    = split(".", each.value.hostname)[0]
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.main.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}