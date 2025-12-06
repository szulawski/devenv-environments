{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "devops-tools";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # Cloud Provider CLIs
    azure-cli              # Azure CLI (az)
    google-cloud-sdk       # GCP CLI (gcloud, gsutil, bq)
    awscli2                # AWS CLI v2
    
    # Kubernetes Tools
    kubectl                # Kubernetes CLI
    kubectx                # Switch between clusters
    # kubens                 # Switch between namespaces
    k9s                    # Terminal UI for Kubernetes
    kubernetes-helm        # Kubernetes package manager
    kustomize              # Kubernetes config customization
    stern                  # Multi-pod log tailing
    kubeval                # Validate Kubernetes YAML
    kube-capacity          # Cluster resource usage
    
    # Container Tools
    docker                 # Docker CLI
    docker-compose         # Docker Compose
    dive                   # Docker image layer inspection
    skopeo                 # Container image operations
    
    # Infrastructure as Code
    terraform              # Infrastructure provisioning
    opentofu               # OpenTofu (Terraform fork)
    terragrunt             # Terraform wrapper
    tflint                 # Terraform linter
    terraform-docs         # Generate Terraform docs
    
    # Configuration Management
    ansible                # Configuration management
    ansible-lint           # Ansible linter
    
    # CI/CD Tools
    gh                     # GitHub CLI
    gitlab-runner          # GitLab CI runner
    
    # Monitoring & Observability
    prometheus             # Metrics monitoring
    grafana                # Metrics visualization
    
    # Network Tools
    curl                   # HTTP client
    wget                   # Download utility
    httpie                 # Modern HTTP client
    jq                     # JSON processor
    yq-go                  # YAML/XML processor
    
    # Security & Secrets
    sops                   # Secrets management
    age                    # Encryption tool
    vault                  # HashiCorp Vault
    
    # Version Control
    git                    # Version control
    git-crypt              # Transparent Git encryption
    
    # Utilities
    watch                  # Execute program periodically
    tree                   # Directory tree viewer
    htop                   # Process viewer
    ncdu                   # Disk usage analyzer
  ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "DevOps Tools Environment"
    echo "========================"
    echo ""
    echo "Cloud Providers:"
    echo "  Azure:  $(az version --output tsv 2>/dev/null | head -n1 || echo 'az')"
    echo "  GCP:    $(gcloud version 2>/dev/null | grep 'Google Cloud SDK' || echo 'gcloud')"
    echo "  AWS:    $(aws --version 2>/dev/null || echo 'aws-cli/2.x')"
    echo ""
    echo "Kubernetes:"
    echo "  kubectl:  $(kubectl version --client --short 2>/dev/null | grep 'Client Version' || echo 'installed')"
    echo "  helm:     $(helm version --short 2>/dev/null || echo 'installed')"
    echo "  k9s:      installed"
    echo ""
    echo "Infrastructure as Code:"
    echo "  Terraform: $(terraform version | head -n1)"
    echo "  Ansible:   $(ansible --version | head -n1)"
    echo ""
    echo "Container Tools:"
    echo "  Docker:  $(docker --version 2>/dev/null || echo 'installed')"
    echo "  dive:    installed"
    echo ""
    echo "Available commands:"
    echo "  Cloud:         az, gcloud, aws"
    echo "  Kubernetes:    kubectl, helm, k9s, kubectx"
    echo "  Containers:    docker, dive, skopeo"
    echo "  IaC:           terraform, terragrunt, ansible"
    echo "  Utilities:     jq, yq, curl, httpie"
    echo "  Security:      vault, sops, age"
  '';
}