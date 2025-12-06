# Node.js/TypeScript Development Environment

Complete development environment for Node.js and TypeScript with the most popular tools.

## What's Included?

### Runtime and Languages
- **Node.js 20** (LTS) - latest stable version with long-term support
- **TypeScript** - TypeScript support

### Package Managers
- **npm** - default package manager (with auto-install dependencies)
- **yarn** - alternative package manager
- **pnpm** - fast and efficient package manager

### Development Tools
- **Git** - version control
- **GitHub CLI (gh)** - work with GitHub from terminal
- **node-gyp** - compile native Node.js extensions
- **jq** - JSON parsing in scripts
- **yq** - YAML/XML parsing
- **docker-compose** - container orchestration

## How to Use?

### Activate Environment
```bash
cd nodejs
devenv shell
```

After activating the environment, you'll see a welcome message with installed versions.

### Common Commands

#### npm
```bash
npm install              # Install dependencies
npm run dev             # Start dev server
npm run build           # Production build
npm test                # Run tests
npm run lint            # Lint code
```

#### yarn (if using yarn)
```bash
yarn install            # Install dependencies
yarn dev                # Start dev server
yarn build              # Production build
yarn test               # Run tests
```

#### pnpm (if using pnpm)
```bash
pnpm install            # Install dependencies
pnpm dev                # Start dev server
pnpm build              # Production build
pnpm test               # Run tests
```

#### TypeScript
```bash
tsc                     # Compile TypeScript
tsc --watch             # Compile in watch mode
tsc --init              # Create tsconfig.json
```

## Using with Databases

This environment doesn't include databases. For database support, use the standalone database environments in the `databases/` directory.

See:
- [PostgreSQL](../databases/postgresql) - for relational database
- [Redis](../databases/redis) - for caching/sessions/queues
- [MongoDB](../databases/mongodb) - for document database
- [MySQL](../databases/mysql) - for relational database

Start a database in a separate terminal:
```bash
# Terminal 1 - Start database
cd ../databases/postgresql
devenv shell

# Terminal 2 - Run your application
cd nodejs
devenv shell
```

## Auto-install Dependencies

If you have a `package.json`, dependencies will be automatically installed when entering the shell.

To disable auto-install, edit `devenv.nix`:

```nix
languages.javascript = {
  enable = true;
  npm = {
    enable = true;
    install.enable = false;  # disable auto-install
  };
};
```

## Git Hooks

You can enable automatic formatting and linting:

```nix
git-hooks.hooks = {
  eslint = {
    enable = true;   # enable ESLint
  };
  prettier = {
    enable = true;   # enable Prettier
  };
};
```

## Environment Variables

- `NODE_ENV` - set to `development`

## Popular Frameworks

This environment works with popular frameworks:
- **Express** - minimal web framework
- **NestJS** - enterprise framework with TypeScript
- **Next.js** - React framework
- **Fastify** - fast web framework
- **Nuxt** - Vue.js framework
- **SvelteKit** - Svelte framework

## Customization

You can easily customize the environment:
- Change Node.js version (e.g., `nodejs_18`, `nodejs_22`)
- Choose preferred package manager
- Add more tools to the `packages` section
- Configure git-hooks
- Add processes that should start automatically
