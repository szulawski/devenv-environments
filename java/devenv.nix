{ pkgs, ... }:

{
  # https://devenv.sh/basics/

  # Environment name
  name = "java-development";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    # JDK - latest LTS (Java 21)
    jdk21

    # Build tools - both Maven and Gradle (projects use different ones)
    maven
    gradle

    # Utility tools
    jq              # JSON parsing in scripts
    yq-go           # YAML/XML parsing

    # Git and version control tools
    git
    gh              # GitHub CLI

    # Debugging and analysis
    visualvm        # JVM profiler

    # Docker/container work (often needed in Java)
    docker-compose

    # Quality & formatting tools
    google-java-format
  ];

  # https://devenv.sh/languages/
  languages.java = {
    enable = true;
    jdk.package = pkgs.jdk21;

    # Maven
    maven = {
      enable = true;
      package = pkgs.maven;
    };

    # Gradle
    gradle = {
      enable = true;
      package = pkgs.gradle;
    };
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo "Java Development Environment"
    echo "============================="
    echo "Java: $(java -version 2>&1 | head -n 1)"
    echo "Maven: $(mvn --version | head -n 1)"
    echo "Gradle: $(gradle --version | grep Gradle)"
    echo ""
    echo "Available commands:"
    echo "Available commands:"
    echo "  mvn clean install    - build Maven project"
    echo "  gradle build         - build Gradle project"
    echo "  visualvm            - launch JVM profiler"
  '';
  # https://devenv.sh/processes/
  # You can add processes that should start automatically
  # processes = {
  #   spring-boot.exec = "mvn spring-boot:run";
  # };

  # https://devenv.sh/pre-commit-hooks/
  # Hooks for automatic code formatting and checking
  pre-commit.hooks = {
    google-java-format = {
      enable = false;  # set to true for automatic formatting
    };
  };

  # https://devenv.sh/variables/
  env = {
    JAVA_HOME = "${pkgs.jdk21}";
    GRADLE_USER_HOME = "./.gradle";
    MAVEN_OPTS = "-Xmx2048m -XX:MaxPermSize=512m";
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
