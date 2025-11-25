# Development Environments Collection

Ready-to-use development environments based on [devenv.sh](https://devenv.sh) for the most popular technology stacks.

> [!TIP]
> You can use these environments as templates for your projects. Just copy desired `devenv.nix` into your repo and customize it to your needs!

## Available Environments

### Languages & Development

#### [Java](./java)
Complete environment for Java development with JDK 21, Maven, Gradle and VisualVM.
- Java 21 (LTS)
- Maven & Gradle
- VisualVM profiler

#### [Node.js/TypeScript](./nodejs)
Environment for JavaScript/TypeScript with Node.js 20, npm, yarn, pnpm.
- Node.js 20 (LTS)
- npm, yarn, pnpm
- TypeScript support
- Auto-install dependencies

#### [Python](./python)
Environment for Python 3.12 with Poetry, pip and development tools.
- Python 3.12
- Poetry & pip
- pytest ready

#### [Go](./go)
Environment for Go 1.22 with golangci-lint, delve debugger, air live reload.
- Go 1.22
- golangci-lint
- delve debugger
- air live reload

#### [DevOps](./devops)
Complete DevOps toolchain for cloud, containers, and infrastructure.
- Azure, GCP, AWS CLIs
- Kubernetes tools (kubectl, helm, k9s)
- Container tools (docker, dive, skopeo)
- Terraform & Ansible
- Vault, SOPS, secrets management

### Databases

#### [PostgreSQL](./databases/postgresql)
Standalone PostgreSQL 15 database environment.
- PostgreSQL 15
- Client tools included
- Persistent data storage

#### [Redis](./databases/redis)
Standalone Redis cache/message broker environment.
- Redis latest
- In-memory data store
- Pub/Sub messaging

#### [MongoDB](./databases/mongodb)
Standalone MongoDB document database environment.
- MongoDB latest
- Document-oriented
- Rich query language

#### [MySQL](./databases/mysql)
Standalone MySQL 8.0 relational database environment.
- MySQL 8.0
- Preconfigured users
- Persistent storage

## 🚀 Quick Start

### Requirements
- [devenv](https://devenv.sh/getting-started/) installed on your system
- [Nix](https://nixos.org/download.html) package manager

### Install devenv (if you don't have it)
```bash
# macOS/Linux
sh <(curl -L https://nixos.org/nix/install)
nix-env -iA devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable
```

### Usage
```bash
# Choose an environment and enter the directory
cd java  # or nodejs, python, go, devops

# Activate the environment
devenv shell

# Now you have access to all the tools!
```

## 📖 Project Structure

```
.
├── java/
│   ├── devenv.nix       # Java environment configuration
│   └── README.md        # Documentation
├── nodejs/
│   ├── devenv.nix       # Node.js environment configuration
│   └── README.md        # Documentation
├── python/
│   ├── devenv.nix       # Python environment configuration
│   └── README.md        # Documentation
├── go/
│   ├── devenv.nix       # Go environment configuration
│   └── README.md        # Documentation
├── devops/
│   ├── devenv.nix       # DevOps tools configuration
│   └── README.md        # Documentation
├── databases/
│   ├── postgresql/      # PostgreSQL database
│   ├── redis/           # Redis cache
│   ├── mongodb/         # MongoDB database
│   └── mysql/           # MySQL database
└── README.md            # This file
```

## 💡 How It Works

Each environment is:
1. **Isolated** - doesn't conflict with your global configuration
2. **Reproducible** - same configuration works everywhere
3. **Declarative** - everything in one `devenv.nix` file
4. **Versionable** - commit to git with your project
5. **Composable** - mix languages with databases as needed

## 🔗 Loosely Coupled Architecture

Language environments and databases are **separate** - this means:
- Use any database with any language
- Run database in one terminal, app in another
- Or use `devenv up` to run databases in background
- Share one database across multiple projects

### Example: Node.js + PostgreSQL

```bash
# Terminal 1 - Start PostgreSQL
cd databases/postgresql
devenv shell

# Terminal 2 - Start your Node.js app
cd nodejs
devenv shell
npm run dev
```

### Example: Background databases

```bash
# Start databases in background
cd databases/postgresql
devenv up

cd databases/redis
devenv up

# Work on your application
cd ../../python
devenv shell
python manage.py runserver
```

## 📚 Additional Resources

- [devenv.sh Documentation](https://devenv.sh)
- [Nix Package Search](https://search.nixos.org/packages)
- [devenv.sh Examples](https://github.com/cachix/devenv/tree/main/examples)


## 📄 License

MIT - use as you wish!





