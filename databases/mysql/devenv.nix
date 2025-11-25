{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "mysql-database";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # MySQL client tools
    mysql80
  ];

  # https://devenv.sh/services/
  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
    
    # Initial databases to create
    initialDatabases = [
      { name = "devdb"; }
    ];
    
    # Ensure service starts
    ensureUsers = [
      {
        name = "devuser";
        password = "devpass";
        ensurePermissions = {
          "devdb.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "MySQL Database Environment"
    echo "=========================="
    echo "MySQL: ${pkgs.mysql80.version}"
    echo ""
    echo "Connection details:"
    echo "  Host:     127.0.0.1"
    echo "  Port:     3306"
    echo "  Database: devdb"
    echo "  User:     devuser"
    echo "  Password: devpass"
    echo ""
    echo "Available commands:"
    echo "  mysql -u devuser -p devdb   - connect to database"
    echo "  mysqldump devdb > backup.sql - backup database"
    echo "  mysql devdb < backup.sql     - restore database"
  '';

  # Shell configuration
  enterShell = ''
    echo ""
    hello
    echo ""
    echo "MySQL is starting... 🐬"
    echo ""
  '';
}
