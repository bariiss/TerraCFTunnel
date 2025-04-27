tunnel_name = "terraform-tunnel"
account_id = "your_account_id_here"
api_token = "your_api_token_here"

services = {
  example = {
    hostname = "example.com", # Replace with your actual hostname
    target = "http://localhost:8080", # Replace with your actual target
    zone_id = "your_zone_id_here", # Replace with your actual zone ID
  }
}