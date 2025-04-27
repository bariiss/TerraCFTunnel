.PHONY: init plan apply destroy help run docker-run

help:
	@echo "Available commands:"
	@echo "  make init       - Initialize Terraform"
	@echo "  make plan       - Plan Terraform changes"
	@echo "  make apply      - Apply Terraform changes"
	@echo "  make destroy    - Destroy Terraform resources (with confirmation)"
	@echo "  make docker-run - Run the CF tunnel in Docker"
	@echo "  make apply-run  - Apply Terraform changes and start the CF tunnel"

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply -auto-approve

destroy:
	@read -p "Are you sure you want to destroy the Terraform resources? (y/n): " confirm; \
	if [ "$$confirm" = "y" ]; then \
		echo "Destroying Terraform resources..."; \
		docker rm -f cf-tunnel 2>/dev/null || true; \
		sleep 60; \
		terraform destroy -auto-approve; \
	else \
		echo "Terraform destroy aborted."; \
	fi

docker-run:
	@CLOUDFLARED_CMD=$$(terraform output -raw cloudflared_command); \
	CLOUDFLARED_ARGS=$${CLOUDFLARED_CMD#cloudflared }; \
	echo "🚀 Starting cloudflared tunnel as Docker daemon…"; \
	docker rm -f cf-tunnel 2>/dev/null || true; \
	docker run -d \
	  --name cf-tunnel \
	  --restart always \
	  --network host \
	  --cap-add NET_ADMIN \
	  --cap-add NET_RAW \
	  cloudflare/cloudflared:latest \
	  $${CLOUDFLARED_ARGS}; \
	echo "✅ cloudflared is up (container: cf-tunnel)"

apply-run:
	@echo "Initializing Terraform..."
	terraform init -input=false
	@echo "Applying Terraform configurations..."
	terraform apply -auto-approve
	$(MAKE) docker-run
