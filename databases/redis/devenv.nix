{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "redis-cache";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # Redis client tools
    redis
  ];

  # https://devenv.sh/services/
  services.redis = {
    enable = true;
    port = 6379;
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "Redis Cache Environment"
    echo "======================="
    echo "Redis: ${pkgs.redis.version}"
    echo ""
    echo "Connection details:"
    echo "  Host:     127.0.0.1"
    echo "  Port:     6379"
    echo ""
    echo "Available commands:"
    echo "  redis-cli               - connect to Redis"
    echo "  redis-cli ping          - test connection"
    echo "  redis-cli info          - server info"
    echo "  redis-cli monitor       - monitor commands"
  '';

  # Shell configuration
  enterShell = ''
    echo ""
    hello
    echo ""
    echo "Redis is starting... 🔴"
    echo ""
  '';
}
