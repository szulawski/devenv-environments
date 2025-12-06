# Python Development Environment

Complete development environment for Python with the most popular tools.

## What's Included?

### Runtime and Languages
- **Python 3.12** - latest stable version
- **pip** - package manager
- **Poetry** - modern dependency and package manager
- **venv** - virtual environment support

### Development Tools
- **Git** - version control
- **GitHub CLI (gh)** - work with GitHub from terminal
- **jq** - JSON parsing in scripts
- **yq** - YAML/XML parsing
- **docker-compose** - container orchestration
- **csvkit** - CSV processing tools

### System Libraries
- **libffi**, **openssl**, **zlib** - often required by Python packages

## How to Use?

### Activate Environment
```bash
cd python
devenv shell
```

After activating the environment, you'll see a welcome message with installed versions.

### Common Commands

#### pip (standard environment)
```bash
pip install -r requirements.txt  # Install dependencies
pip install package-name         # Install package
pip freeze > requirements.txt    # Export dependencies
python -m venv venv              # Create venv (if not using Poetry)
```

#### Poetry (recommended for new projects)
```bash
poetry install              # Install dependencies
poetry add package-name     # Add package
poetry remove package-name  # Remove package
poetry run python app.py    # Run with Poetry
poetry shell                # Activate Poetry shell
```

#### Running Applications
```bash
# Django
python manage.py runserver
python manage.py migrate
python manage.py createsuperuser

# FastAPI/Uvicorn
uvicorn main:app --reload

# Flask
flask run
export FLASK_APP=app.py
export FLASK_ENV=development
```

#### Testing
```bash
pytest                      # Run tests
pytest -v                   # Verbose output
pytest --cov                # With coverage
pytest tests/test_file.py   # Specific file
```

## Using with Databases

This environment doesn't include databases. For database support, use the standalone database environments in the `databases/` directory.

See:
- [PostgreSQL](../databases/postgresql) - for relational database
- [Redis](../databases/redis) - for caching/Celery task queue
- [MongoDB](../databases/mongodb) - for document database
- [MySQL](../databases/mysql) - for relational database

Start a database in a separate terminal:
```bash
# Terminal 1 - Start database
cd ../databases/postgresql
devenv shell

# Terminal 2 - Run your application
cd python
devenv shell
```

## Auto-install Dependencies

### With pip and venv

If you have a `requirements.txt`, dependencies will be automatically installed:

```nix
venv = {
  enable = true;
  requirements = ./requirements.txt;
};
```
```

### With Poetry
Poetry will automatically install dependencies from `pyproject.toml` when entering the shell:

```nix
poetry = {
  enable = true;
  activate.enable = true;
  install.enable = true;
};
```

## Git Hooks

You can enable automatic formatting and linting:

```nix
git-hooks.hooks = {
  black = {
    enable = true;   # auto-formatting
  };
  ruff = {
    enable = true;   # fast linter (replaces flake8, pylint)
  };
  isort = {
    enable = true;   # import sorting
  };
};
```

## Environment Variables

- `PYTHONUNBUFFERED = "1"` - immediate output display (no buffering)

## Popular Frameworks and Libraries

This environment works with popular frameworks:

### Web Frameworks
- **Django** - full-featured web framework
- **FastAPI** - modern, fast API framework
- **Flask** - lightweight web framework
- **Starlette** - ASGI framework

### Data Science
Install as needed:
- **pandas** - data analysis
- **numpy** - numerical computing
- **matplotlib/seaborn** - visualization
- **scikit-learn** - machine learning
- **jupyter** - interactive notebooks (install with `pip install jupyter`)

### Task Queues
- **Celery** - distributed task queue (uses Redis)
- **RQ** - simple task queue

## Customization

You can easily customize the environment:
- Change Python version (e.g., `"3.11"`, `"3.10"`)
- Choose between pip and Poetry
- Add more tools to the `packages` section
- Configure git-hooks
- Add processes that should start automatically
