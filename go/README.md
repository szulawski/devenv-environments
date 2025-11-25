# Go Development Environment

Complete development environment for Go with the most popular tools.

## What's Included?

### Runtime and Languages
- **Go 1.22** - latest stable version

### Development Tools
- **Git** - version control
- **GitHub CLI (gh)** - work with GitHub from terminal
- **gopls** - Go language server (for IDEs)
- **delve** - Go debugger
- **golangci-lint** - fast linters runner
- **go-tools** - additional tools (goimports, gorename, etc.)
- **gomodifytags** - modify struct tags
- **impl** - generate method stubs for interfaces

### Build and Deployment
- **goreleaser** - release automation
- **air** - live reload for Go apps (hot reload in development)
- **docker-compose** - container orchestration

### Protocol Buffers
- **protobuf** - Protocol Buffers compiler
- **protoc-gen-go** - Go plugin for protoc

### Utility Tools
- **jq** - JSON parsing in scripts
- **yq** - YAML/XML parsing

## How to Use?

### Activate Environment
```bash
cd go
devenv shell
```

After activating the environment, you'll see a welcome message with installed versions.

### Common Commands

#### Basic Operations
```bash
go run .                    # Run application
go run ./cmd/api            # Run specific package
go build                    # Compile binary
go build -o myapp           # Compile with name
go install                  # Install to $GOPATH/bin
```

#### Modules and Dependencies
```bash
go mod init github.com/user/project  # Initialize module
go mod tidy                 # Clean up dependencies
go mod download             # Download dependencies
go get package@version      # Add/update package
go mod vendor               # Vendor dependencies
```

#### Testing
```bash
go test ./...               # All tests
go test -v ./...            # Verbose output
go test -cover ./...        # With coverage
go test -bench=.            # Benchmarks
go test -race ./...         # Race detector
```

#### Formatting and Linting
```bash
go fmt ./...                # Format code
gofmt -s -w .               # Simplify + write
goimports -w .              # Format + organize imports
golangci-lint run           # Run all linters
golangci-lint run --fix     # With automatic fixes
```

#### Debugging
```bash
dlv debug                   # Debug current package
dlv test                    # Debug tests
dlv attach <pid>            # Attach to process
```

#### Live Reload (development)
```bash
air                         # Run with live reload
air -c .air.toml            # With custom config
```

#### Code Generation
```bash
go generate ./...           # Run go:generate
impl 'r *Receiver' io.Reader  # Generate interface methods
gomodifytags -file file.go -struct MyStruct -add-tags json  # Add tags
```

## Using with Databases

This environment doesn't include databases. For database support, use the standalone database environments in the `databases/` directory.

See:
- [PostgreSQL](../databases/postgresql) - for relational database
- [Redis](../databases/redis) - for caching/distributed locks
- [MongoDB](../databases/mongodb) - for document database
- [MySQL](../databases/mysql) - for relational database

Start a database in a separate terminal:
```bash
# Terminal 1 - Start database
cd ../databases/postgresql
devenv shell

# Terminal 2 - Run your application
cd go
devenv shell
```

## Pre-commit Hooks

You can enable automatic formatting and linting:

```nix
pre-commit.hooks = {
  gofmt = {
    enable = true;   # automatic formatting
  };
  golangci-lint = {
    enable = true;   # automatic linting
  };
};
```

## Environment Variables

- `GOPATH` - set to `.go` in project directory
- `CGO_ENABLED = "1"` - CGO enabled (for packages with C)

## Popular Frameworks and Libraries

This environment works with popular frameworks:

### Web Frameworks
- **Gin** - fast web framework
- **Echo** - high-performance framework
- **Fiber** - Express-inspired framework
- **Chi** - lightweight router
- **Gorilla Mux** - powerful router

### API and gRPC
- **gRPC** - Google RPC framework
- **Protocol Buffers** - serialization
- **Twirp** - RPC framework
- **Connect** - simple RPC

### Databases
- **GORM** - ORM
- **sqlx** - extensions for database/sql
- **pgx** - PostgreSQL driver
- **go-redis** - Redis client
- **mongo-driver** - MongoDB driver

### CLI Tools
- **Cobra** - CLI framework
- **Viper** - configuration
- **Survey** - interactive prompts

### Testing
- **Testify** - testing toolkit
- **GoMock** - mocking framework
- **Ginkgo** - BDD testing

## Air Configuration (live reload)

Create `.air.toml` in your project:

```toml
root = "."
tmp_dir = "tmp"

[build]
  cmd = "go build -o ./tmp/main ."
  bin = "tmp/main"
  include_ext = ["go", "tpl", "tmpl", "html"]
  exclude_dir = ["assets", "tmp", "vendor"]
  delay = 1000
```

## Customization

You can easily customize the environment:
- Change Go version (e.g., `go_1_21`, `go_1_23`)
- Add more tools to the `packages` section
- Configure pre-commit hooks
- Add processes that should start automatically
- Customize environment variables (CGO, build tags, etc.)
