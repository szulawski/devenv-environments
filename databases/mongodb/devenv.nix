{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "mongodb-database";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # MongoDB client tools
    mongodb-tools
  ];

  # https://devenv.sh/services/
  services.mongodb = {
    enable = true;
    # additionalArgs = [ "--quiet" ];
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "MongoDB Database Environment"
    echo "============================"
    echo "MongoDB: ${pkgs.mongodb.version}"
    echo ""
    echo "Connection details:"
    echo "  URI: mongodb://127.0.0.1:27017"
    echo ""
    echo "Available commands:"
    echo "  mongosh                 - connect to MongoDB"
    echo "  mongosh mydb            - connect to specific database"
    echo "  mongodump               - backup database"
    echo "  mongorestore            - restore database"
  '';

  # Shell configuration
  enterShell = ''
    echo ""
    hello
    echo ""
    echo "MongoDB is starting... 🍃"
    echo ""
  '';
}
