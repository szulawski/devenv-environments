# DevOps Tools Environment

Complete DevOps toolchain with cloud providers, Kubernetes, IaC, containers, and monitoring tools.

## What's Included?

### Cloud Provider CLIs
- **Azure CLI (az)** - Microsoft Azure command-line tool
- **Google Cloud SDK (gcloud)** - GCP command-line tools
- **AWS CLI v2 (aws)** - Amazon Web Services CLI

### Kubernetes Tools
- **kubectl** - Kubernetes command-line tool
- **kubectx/kubens** - Switch between clusters and namespaces
- **k9s** - Terminal UI for Kubernetes
- **helm** - Kubernetes package manager
- **kustomize** - Kubernetes configuration customization
- **stern** - Multi-pod and multi-container log tailing
- **kubeval** - Validate Kubernetes YAML files
- **kube-capacity** - View cluster resource usage

### Container Tools
- **Docker** - Container runtime and CLI
- **Docker Compose** - Multi-container orchestration
- **dive** - Inspect Docker image layers
- **Skopeo** - Work with container images and registries

### Infrastructure as Code
- **Terraform** - Infrastructure provisioning
- **OpenTofu** - Open-source Terraform alternative
- **Terragrunt** - Terraform wrapper for DRY configs
- **tflint** - Terraform linter
- **terraform-docs** - Generate Terraform documentation

### Configuration Management
- **Ansible** - Automation and configuration management
- **ansible-lint** - Best practices checker for Ansible

### CI/CD Tools
- **GitHub CLI (gh)** - GitHub from command line
- **GitLab Runner** - GitLab CI/CD runner

### Monitoring & Observability
- **Prometheus** - Metrics collection and monitoring
- **Grafana** - Metrics visualization and dashboards

### Security & Secrets
- **SOPS** - Secrets management (encrypted files)
- **Age** - Modern encryption tool
- **Vault** - HashiCorp Vault for secrets management

### Network & Utilities
- **curl, wget, httpie** - HTTP clients
- **jq, yq** - JSON/YAML processors
- **git, git-crypt** - Version control with encryption
- **watch, tree, htop, ncdu** - System utilities

## How to Use?

### Activate Environment

Due to the use of unfree and unsupported packages, you need to set the `NIXPKGS_ALLOW_UNFREE=1` and `NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1` environment variables and use the `--impure` flag to start the environment.

```bash
cd devops
NIXPKGS_ALLOW_UNFREE=1 NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 devenv shell --impure
```

The environment comes with helpful aliases:
- `k` = `kubectl`
- `kgp` = `kubectl get pods`
- `kgs` = `kubectl get svc`
- `kgd` = `kubectl get deployments`
- `tf` = `terraform`
- `tfi` = `terraform init`
- `tfp` = `terraform plan`
- `tfa` = `terraform apply`
- `ans` = `ansible`
- `ansp` = `ansible-playbook`

## Common Workflows

### Cloud Provider Setup

#### Azure
```bash
# Login
az login

# Set subscription
az account set --subscription "My Subscription"

# List resources
az resource list --output table
```

#### GCP
```bash
# Login
gcloud auth login

# Set project
gcloud config set project my-project-id

# List instances
gcloud compute instances list
```

#### AWS
```bash
# Configure
aws configure

# List S3 buckets
aws s3 ls

# List EC2 instances
aws ec2 describe-instances
```

### Kubernetes Operations

#### Cluster Management
```bash
# View contexts
kubectx

# Switch context
kubectx production

# Switch namespace
kubens my-namespace

# Interactive cluster UI
k9s
```

#### Resource Management
```bash
# Get resources
kubectl get pods
kubectl get deployments
kubectl get services

# Describe resource
kubectl describe pod my-pod

# View logs
kubectl logs my-pod
stern my-app  # Multi-pod logs

# Execute command in pod
kubectl exec -it my-pod -- /bin/bash

# Port forwarding
kubectl port-forward svc/my-service 8080:80
```

#### Helm Operations
```bash
# Add repository
helm repo add stable https://charts.helm.sh/stable
helm repo update

# Search charts
helm search repo nginx

# Install chart
helm install my-release stable/nginx

# List releases
helm list

# Upgrade release
helm upgrade my-release stable/nginx

# Uninstall
helm uninstall my-release
```

### Container Operations

#### Docker
```bash
# Build image
docker build -t myapp:latest .

# Run container
docker run -d -p 8080:80 myapp:latest

# List containers
docker ps

# View logs
docker logs container-id

# Execute command
docker exec -it container-id /bin/bash
```

#### Dive - Image Inspection
#### Dive - Image Inspection
```bash
# Inspect image layers
dive myapp:latest

# Analyze efficiency
dive --ci myapp:latest
```

#### Skopeo - Image Operations
```bash
# Inspect remote image
skopeo inspect docker://docker.io/library/alpine:latest

# Copy image between registries
skopeo copy docker://source/image:tag docker://dest/image:tag

# Delete image from registry
skopeo delete docker://registry/image:tag
```

### Infrastructure as Code
```bash
# Initialize
terraform init

# Format code
terraform fmt

# Validate
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# Destroy infrastructure
terraform destroy
```

#### Terragrunt
```bash
# Run in all modules
terragrunt run-all plan
terragrunt run-all apply

# Run in single module
terragrunt plan
terragrunt apply
```

#### Terraform Linting
```bash
# Lint Terraform files
tflint

# Generate documentation
terraform-docs markdown table . > README.md
```

### Configuration Management

#### Ansible
```bash
# Ping hosts
ansible all -m ping

# Run ad-hoc command
ansible webservers -m shell -a "uptime"

# Run playbook
ansible-playbook site.yml

# Check syntax
ansible-playbook site.yml --syntax-check

# Dry run
ansible-playbook site.yml --check

# Lint playbook
ansible-lint site.yml
```

### Secrets Management

#### SOPS
```bash
# Encrypt file
sops --encrypt secret.yaml > secret.enc.yaml

# Decrypt file
sops --decrypt secret.enc.yaml

# Edit encrypted file
sops secret.enc.yaml
```

#### Vault
```bash
# Start dev server (in background)
vault server -dev &

# Set address
export VAULT_ADDR='http://127.0.0.1:8200'

# Write secret
vault kv put secret/myapp password=secret123

# Read secret
vault kv get secret/myapp
```

## Useful Commands

### Network & Debugging
```bash
# Test HTTP endpoint
curl https://api.example.com
httpie https://api.example.com

# Parse JSON response
curl https://api.example.com | jq '.data'

# Parse YAML
cat config.yaml | yq '.spec.replicas'

# Watch command output
watch kubectl get pods

# Monitor system
htop

# Check disk usage
ncdu
```

### Multi-cloud Resource Listing
```bash
# Azure
az vm list --output table

# GCP
gcloud compute instances list

# AWS
aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,State.Name,InstanceType]' --output table

# Kubernetes
kubectl get nodes
kubectl get pods --all-namespaces
```

## Configuration

### Git Hooks

Enable automatic validation and linting:

```nix
git-hooks.hooks = {
  terraform-format = {
    enable = true;   # auto-format Terraform
  };
  ansible-lint = {
    enable = true;   # lint Ansible playbooks
  };
};
```

### Custom Kubernetes Config

The environment uses a local kubeconfig at `.kube/config`. To use your system config:

```bash
cp ~/.kube/config .kube/config
```

Or set a different path:
```bash
export KUBECONFIG=~/.kube/config
```

## Environment Variables

- `KUBECONFIG` - Kubernetes config location (isolated)
- `TF_PLUGIN_CACHE_DIR` - Terraform plugin cache
- `ANSIBLE_CONFIG` - Ansible configuration file
- `DOCKER_CONFIG` - Docker configuration directory

## Tips & Best Practices

### Kubernetes
- Use `kubectx`/`kubens` to avoid mistakes with wrong cluster/namespace
- Use `k9s` for interactive cluster management
- Use `stern` for streaming logs from multiple pods
- Always verify context before destructive operations

### Terraform
- Always run `terraform plan` before `apply`
- Use workspaces for multiple environments
- Enable backend for state management
- Use `tflint` to catch issues early

### Docker
- Use `dive` to optimize image sizes
- Multi-stage builds for smaller images
- Use `.dockerignore` to exclude files
- Scan images for vulnerabilities

### Ansible
- Use `--check` mode for dry runs
- Use `ansible-lint` before committing
- Use vaults for sensitive data
- Tag plays for selective execution

### Security
- Never commit secrets to git
- Use SOPS or Vault for secrets
- Rotate credentials regularly
- Use least privilege principle
- Enable MFA where possible

## Integration with Databases

This environment works great with database environments:

```bash
# Terminal 1 - Start database
cd ../databases/postgresql
devenv shell

# Terminal 2 - Deploy to Kubernetes
cd ../devops
devenv shell
kubectl apply -f deployment.yaml
```

## Customization

Add more tools by editing `devenv.nix`:

```nix
packages = with pkgs; [
  # Add your tools
  argocd           # GitOps continuous delivery
  flux             # GitOps toolkit
  istioctl         # Istio service mesh
  linkerd          # Linkerd service mesh
  velero           # Kubernetes backup
  kubeseal         # Sealed Secrets
  podman           # Daemonless container engine
  buildah          # Build OCI containers
];
```

## Common Use Cases

- **Multi-cloud deployments** - Manage resources across Azure, GCP, AWS
- **Kubernetes operations** - Deploy and manage containerized applications
- **Infrastructure automation** - Terraform/Ansible for reproducible infrastructure
- **CI/CD pipelines** - Build and deploy with GitLab/GitHub
- **Monitoring setup** - Deploy Prometheus and Grafana
- **Security audits** - Scan containers and infrastructure
- **Disaster recovery** - Backup and restore procedures
