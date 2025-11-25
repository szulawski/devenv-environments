# Java Development Environment

Complete development environment for Java with the most popular tools.

## What's Included?

### Languages and Runtime
- **Java 21** (LTS) - latest stable version with long-term support

### Build Tools
- **Maven** - dependency management and project building
- **Gradle** - alternative build system

### Development Tools
- **Git** - version control
- **GitHub CLI (gh)** - work with GitHub from terminal
- **VisualVM** - JVM profiler for application performance analysis
- **google-java-format** - automatic code formatting according to Google standard

### Utility Tools
- **jq** - JSON parsing in scripts
- **yq** - YAML/XML parsing
- **docker-compose** - container orchestration

## How to Use?

### Activate the environment
```bash
cd java
devenv shell
```

### Quick Start
After activating the environment, you'll see a welcome message with installed versions.

### Common Commands

#### Maven
```bash
mvn clean install    # Compile and install dependencies
mvn clean package    # Compile and package
mvn spring-boot:run  # Run Spring Boot application
mvn test            # Run tests
```

#### Gradle
```bash
gradle build        # Build project
gradle test         # Run tests
gradle bootRun      # Run Spring Boot application
gradle clean build  # Clean and build from scratch
```

#### Other Tools
```bash
visualvm            # Launch JVM profiler
gh repo list       # List GitHub repositories
```
## Using with Databases

This environment doesn't include databases. For database support, use the standalone database environments in the `databases/` directory.

See:
- [PostgreSQL](../databases/postgresql) - for relational database
- [Redis](../databases/redis) - for caching/message broker
- [MongoDB](../databases/mongodb) - for document database
- [MySQL](../databases/mysql) - for relational database

Start a database in a separate terminal:
```bash
# Terminal 1 - Start database
cd ../databases/postgresql
devenv shell

# Terminal 2 - Run your application
cd java
devenv shell
```

## Environment Variables

- `JAVA_HOME` - path to JDK
- `GRADLE_USER_HOME` - Gradle cache location (in project)
- `MAVEN_OPTS` - JVM options for Maven (increased memory)

## Customization

You can easily customize the environment:
- Change JDK version (e.g., `jdk17`, `jdk11`)
- Add more tools to the `packages` section
- Configure pre-commit hooks for automatic formatting
- Add processes that should start automatically
