{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  
  # Environment name
  name = "python-development";

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
    
    # System libraries often needed for Python packages
    libffi
    openssl
    zlib
    
    # Data processing tools
    csvkit          # CSV processing
  ];

  # https://devenv.sh/languages/
  languages.python = {
    enable = true;
    version = "3.12";  # Python 3.12
    
    # Virtual environment
    venv = {
      enable = true;
      requirements = ./requirements.txt;  # Auto-install if exists
    };
    
    # Poetry support
    poetry = {
      enable = true;
      activate.enable = true;
      install.enable = true;  # Auto-install dependencies
    };
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "Python Development Environment"
    echo "=============================="
    echo "Python: $(python --version)"
    echo "pip: $(pip --version | cut -d' ' -f1-2)"
    if command -v poetry &> /dev/null; then
      echo "Poetry: $(poetry --version)"
    fi
    echo ""
    echo "Available commands:"
    echo "  python              - Python interpreter"
    echo "  pip install -r requirements.txt"
    echo "  poetry install      - install dependencies (Poetry)"
    echo "  poetry run python   - run with Poetry"
    echo "  pytest              - run tests"
  '';

  # https://devenv.sh/processes/
  # You can add processes that should start automatically
  # processes = {
  #   dev-server.exec = "python manage.py runserver";  # Django
  #   # or
  #   # fastapi-dev.exec = "uvicorn main:app --reload";  # FastAPI
  # };

  # https://devenv.sh/pre-commit-hooks/
  # Hooks for automatic code formatting and linting
  pre-commit.hooks = {
    black = {
      enable = false;  # set to true for automatic formatting
    };
    ruff = {
      enable = false;  # set to true for fast linting
    };
    isort = {
      enable = false;  # set to true for import sorting
    };
  };

  # https://devenv.sh/variables/
  env = {
    PYTHONUNBUFFERED = "1";
    # PIP_REQUIRE_VIRTUALENV = "true";  # Force venv usage
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
