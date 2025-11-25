{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "postgresql-database";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # PostgreSQL client tools
    postgresql
  ];

  # https://devenv.sh/services/
  services.postgres = {
    enable = true;
    package = pkgs.postgresql_15;
    
    # Listen on localhost only
    listen_addresses = "127.0.0.1";
    port = 5432;
    
    # Initial databases to create
    initialDatabases = [
      { name = "devdb"; }
    ];
    
    # Initial SQL script (optional)
    # initialScript = ''
    #   CREATE USER myuser WITH PASSWORD 'mypassword';
    #   GRANT ALL PRIVILEGES ON DATABASE devdb TO myuser;
    # '';
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "PostgreSQL Database Environment"
    echo "==============================="
    echo "PostgreSQL: ${pkgs.postgresql_15.version}"
    echo ""
    echo "Connection details:"
    echo "  Host:     127.0.0.1"
    echo "  Port:     5432"
    echo "  Database: devdb"
    echo "  User:     $USER"
    echo ""
    echo "Available commands:"
    echo "  psql devdb              - connect to database"
    echo "  psql -l                 - list databases"
    echo "  createdb mydb           - create new database"
    echo "  dropdb mydb             - drop database"
  '';

  # Shell configuration
  enterShell = ''
    echo ""
    hello
    echo ""
    echo "PostgreSQL is starting... 🐘"
    echo ""
  '';
}
