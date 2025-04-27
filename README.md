# TerraCFTunnel

A project that uses Terraform to provision and manage Cloudflare Tunnels through Infrastructure as Code.

## Overview

TerraCFTunnel allows you to provision Cloudflare Tunnels using Terraform and automatically deploy them as Docker containers. This approach provides:

- **Infrastructure as Code**: Use Terraform to declare and manage your Cloudflare Tunnel configurations
- **Reproducibility**: Easily recreate your tunnels with consistent configuration
- **Docker Integration**: Run your tunnels in Docker containers for better isolation and management

## Prerequisites

- Docker
- Terraform (>= 0.14.0)
- Cloudflare account with access to create tunnels
- Cloudflare API token with the required permissions

### Cloudflare API Token Permissions

To use this project, you need to create a Cloudflare API token with the following permissions:

1. Go to the Cloudflare dashboard and navigate to "My Profile" → "API Tokens"
2. Click "Create Token" → "Custom Permissions"
3. Add the following permissions:
   - **Account** → **Cloudflare Tunnel**: Edit
   - **Account** → **Access: Apps and Policies**: Edit (Required for Zero Trust UI)
   - **Zone** → **DNS**: Edit

Without these permissions, the Terraform provider won't be able to create and manage tunnels properly.

## Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/bariiss/TerraCFTunnel.git
   cd TerraCFTunnel
   ```

2. Configure your Terraform variables by editing the `services.auto.tfvars` file:
   ```
   # Example services.auto.tfvars
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
   ```

   You must update:
   - `tunnel_name`: A name for your Cloudflare tunnel
   - `account_id`: Your Cloudflare account ID (found in the Cloudflare dashboard URL)
   - `api_token`: Your Cloudflare API token with proper permissions
   - `services`: The services you want to expose through the tunnel
     - Each service needs a hostname (DNS record), target (local service address), and zone_id (Cloudflare zone ID for the domain)

3. Use the provided Makefile commands to manage your infrastructure

## Available Commands

This project includes a Makefile to simplify common operations:

```
make init       - Initialize Terraform
make plan       - Plan Terraform changes
make apply      - Apply Terraform changes
make destroy    - Destroy Terraform resources (with confirmation)
make docker-run - Run the Cloudflare tunnel in Docker
make apply-run  - Apply Terraform changes and start the Cloudflare tunnel
```

## Workflow

### Provisioning and Starting a Tunnel

To provision infrastructure and start a tunnel:

```
make apply-run
```

This will:
1. Initialize Terraform
2. Apply the Terraform configuration
3. Retrieve the Cloudflare tunnel command from Terraform outputs
4. Start a Docker container running the Cloudflare tunnel

### Destroying Resources

To destroy the infrastructure:

```
make destroy
```

This will:
1. Prompt for confirmation
2. Remove the running Docker container
3. Wait for resources to clean up (60 seconds)
4. Destroy the Terraform-managed resources

## Architecture

The project uses:
- **Terraform**: To provision and manage Cloudflare tunnel resources
- **Docker**: To run the Cloudflare tunnel client (cloudflared) in a container
- **Makefile**: To simplify and standardize operations

The Terraform configuration outputs the necessary cloudflared command that's automatically used when starting the Docker container.

## Troubleshooting

If the tunnel doesn't start correctly:
1. Check the Docker container logs: `docker logs cf-tunnel`
2. Verify your Terraform configuration and outputs
3. Ensure your Cloudflare credentials are properly configured

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.