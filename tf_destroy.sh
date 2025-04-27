#!/usr/bin/env bash
set -euo pipefail

read -p "Are you sure you want to destroy the Terraform resources? (y/n): " confirm
if [ "$confirm" = "y" ]; then
  echo "Destroying Terraform resources..."
  docker rm -f cf-tunnel 2>/dev/null || true
  sleep 60
  terraform destroy -auto-approve
else
  echo "Terraform destroy aborted."
fi