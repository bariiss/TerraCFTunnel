tunnel_name = "terraform-tunnel" # Replace with your actual tunnel name
account_id = "your_account_id_here" # Replace with your actual CF Account ID
api_token = "your_api_token_here" # Replace with your actual CF API token

services = {
  example = {
    hostname = "example.com", # Replace with your actual hostname
    target = "http://localhost:8080", # Replace with your actual target
    zone_id = "your_zone_id_here", # Replace with your actual CF Zone ID
  }
}