{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "go";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # Go
    go
    gopls
    
    # Utilities
    tree
    htop
    ncdu
  ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "Go Environment"
    echo "=============="
    echo "Go: $(go version)"
    echo "gopls: $(gopls version)"
    echo ""
    echo "Available commands:"
    echo "  go         - Go compiler"
    echo "  gopls      - Go language server"
    echo "  tree       - Directory tree viewer"
    echo "  htop       - Process viewer"
    echo "  ncdu       - Disk usage analyzer"
  '';
}
