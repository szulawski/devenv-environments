{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "nodejs-typescript-development";

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
    
    # Performance and debugging
    nodejs.pkgs.node-gyp  # Native addons compilation
  ];

  # https://devenv.sh/languages/
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_20;  # Node.js 20 LTS
    
    npm = {
      enable = true;
      install.enable = true;  # Auto-install dependencies on shell enter
    };
    
    yarn = {
      enable = true;
      install.enable = false;
    };
    
    pnpm = {
      enable = true;
      install.enable = false;
    };
  };
  
  languages.typescript = {
    enable = true;
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "Node.js/TypeScript Development Environment"
    echo "=========================================="
    echo "Node.js: $(node --version)"
    echo "npm: $(npm --version)"
    echo "yarn: $(yarn --version 2>/dev/null || echo 'not active')"
    echo "pnpm: $(pnpm --version 2>/dev/null || echo 'not active')"
    echo "TypeScript: $(tsc --version 2>/dev/null || echo 'install with: npm i -g typescript')"
    echo ""
    echo "Available commands:"
    echo "  npm install          - install dependencies"
    echo "  npm run dev          - start development server"
    echo "  npm run build        - build for production"
    echo "  npm test             - run tests"
    echo "  tsc                  - TypeScript compiler"
  '';

  # https://devenv.sh/processes/
  # You can add processes that should start automatically
  # processes = {
  #   dev-server.exec = "npm run dev";
  # };

  # https://devenv.sh/pre-commit-hooks/
  # Hooks for automatic code formatting and linting
  pre-commit.hooks = {
    eslint = {
      enable = false;  # set to true for automatic linting
    };
    prettier = {
      enable = false;  # set to true for automatic formatting
    };
  };

  # https://devenv.sh/variables/
  env = {
    NODE_ENV = "development";
    # NPM_CONFIG_PREFIX = "./.npm-global";  # Local npm global packages
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
