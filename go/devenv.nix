{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "go-development";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # Git and version control
    git
    gh              # GitHub CLI
    
    # Utility tools
    jq              # JSON parsing
    yq-go           # YAML/XML parsing
    
    # Docker for containerization
    docker-compose
    
    # Go development tools
    golangci-lint   # Fast linters runner
    gopls           # Go language server
    delve           # Debugger
    go-tools        # Additional Go tools (goimports, etc.)
    gomodifytags    # Modify struct tags
    impl            # Generate method stubs
    
    # Protocol Buffers (often used with Go microservices)
    protobuf
    protoc-gen-go
    
    # Build tools
    goreleaser      # Release automation
    air             # Live reload for Go apps
  ];

  # https://devenv.sh/languages/
  languages.go = {
    enable = true;
    package = pkgs.go_1_22;  # Go 1.22
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "Go Development Environment"
    echo "=========================="
    echo "Go: $(go version)"
    echo "golangci-lint: $(golangci-lint --version | head -n 1)"
    echo ""
    echo "Available commands:"
    echo "  go run .             - run application"
    echo "  go build             - build binary"
    echo "  go test ./...        - run all tests"
    echo "  go mod tidy          - clean up dependencies"
    echo "  golangci-lint run    - run linters"
    echo "  air                  - live reload dev server"
    echo "  dlv debug            - start debugger"
  '';

  # https://devenv.sh/processes/
  # You can add processes that should start automatically
  # processes = {
  #   api-server.exec = "go run ./cmd/api";
  #   # or with live reload
  #   # dev-server.exec = "air";
  # };

  # https://devenv.sh/pre-commit-hooks/
  # Hooks for automatic code formatting and linting
  pre-commit.hooks = {
    gofmt = {
      enable = false;  # set to true for automatic formatting
    };
    golangci-lint = {
      enable = false;  # set to true for automatic linting
    };
  };

  # https://devenv.sh/variables/
  env = {
    GOPATH = "$DEVENV_ROOT/.go";
    CGO_ENABLED = "1";
    # GO111MODULE = "on";  # Modern module mode (default in Go 1.16+)
  };

  # Shell configuration
  enterShell = ''
    echo ""
    hello
    echo ""
    echo "Environment ready! 🚀"
    echo ""
  '';
}
