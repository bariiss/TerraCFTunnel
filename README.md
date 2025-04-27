# TerraCFTunnel

A Terraform project for automating the deployment and management of Cloudflare Tunnels.

## Overview

TerraCFTunnel provides Infrastructure as Code (IaC) capabilities for creating and managing Cloudflare Tunnels, allowing you to securely expose local services to the internet without opening ports in your firewall.

## Features

- Automated creation and configuration of Cloudflare Tunnels
- DNS record management for tunnel services
- Multi-service support with a single tunnel
- Secure handling of credentials and tokens

## Prerequisites

- Terraform v1.0.0+
- Cloudflare account
- Cloudflare API token with the required permissions
- `cloudflared` CLI (for running tunnels locally)

## Quick Start

1. Clone this repository
2. Update the `services.auto.tfvars` file with your Cloudflare account details and service configurations
3. Initialize Terraform:
   ```
   terraform init
   ```
4. Plan your deployment:
   ```
   terraform plan
   ```
5. Apply the configuration:
   ```
   terraform apply
   ```
6. Run the tunnel:
   ```
   ./tf_apply_run.sh
   ```

## Configuration

### Required Variables

- `account_id`: Your Cloudflare account ID
- `api_token`: Your Cloudflare API token
- `tunnel_name`: The name for your Cloudflare tunnel
- `services`: A map of services to expose through the tunnel

### Service Configuration

Each service requires:
- `hostname`: The hostname to use for the service
- `target`: The local address of the service (e.g., http://localhost:8080)
- `zone_id`: The Cloudflare Zone ID for the domain

Example configuration in `services.auto.tfvars`:

```hcl
tunnel_name = "terraform-tunnel"
account_id = "your-cloudflare-account-id"
api_token = "your-cloudflare-api-token"

services = {
  web_app = { 
    hostname = "app.example.com",
    target = "http://localhost:8080",
    zone_id = "your-cloudflare-zone-id"
  }
}
```

## Cleanup

To destroy all resources created by Terraform:

```
./tf_destroy.sh
```

## Security Notes

- The `services.auto.tfvars` file contains sensitive information. Keep it secure and never commit it to public repositories.
- Consider using environment variables or a secrets manager for production deployments.

## License

MIT