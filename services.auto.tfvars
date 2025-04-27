tunnel_name = "your-tunnel-name"
account_id = "your-cloudflare-account-id"
api_token = "your-cloudflare-api-token"

services = {
  service1 = { 
    hostname = "service1.yourdomain.com",
    target = "http://localhost:8080",
    zone_id = "your-cloudflare-zone-id"
  }
  # Add more services as needed
}