# PostgreSQL Database Environment

Standalone PostgreSQL database environment that can be used with any application.

## What's Included?

- **PostgreSQL 15** - latest stable version
- **psql** - PostgreSQL client
- **PostgreSQL tools** - createdb, dropdb, pg_dump, pg_restore

## How to Use?

### Start the Database

```bash
cd databases/postgresql
devenv shell
```

The database will start automatically when you enter the shell.

### Connection Details

- **Host**: `127.0.0.1`
- **Port**: `5432`
- **Database**: `devdb` (default)
- **User**: Your system username
- **Password**: None (trust authentication for local connections)

### Common Commands

#### Connect to Database
```bash
psql devdb              # Connect to default database
psql -l                 # List all databases
psql -d mydb -U myuser  # Connect with specific user
```

#### Database Management
```bash
createdb myapp          # Create new database
dropdb myapp            # Drop database
pg_dump devdb > backup.sql     # Backup database
psql devdb < backup.sql        # Restore from backup
```

#### SQL Queries
```bash
# From command line
psql devdb -c "SELECT version();"

# Interactive session
psql devdb
# Then inside psql:
\dt                     # List tables
\d tablename           # Describe table
\du                    # List users
\l                     # List databases
\q                     # Quit
```

## Using with Applications

### From Node.js/TypeScript

```javascript
// Using pg package
const { Pool } = require('pg');

const pool = new Pool({
  host: '127.0.0.1',
  port: 5432,
  database: 'devdb',
  user: process.env.USER,
});
```

### From Python

```python
# Using psycopg2
import psycopg2

conn = psycopg2.connect(
    host="127.0.0.1",
    port=5432,
    database="devdb",
    user=os.environ['USER']
)
```

### From Java

```java
// JDBC connection string
String url = "jdbc:postgresql://127.0.0.1:5432/devdb";
String user = System.getenv("USER");

Connection conn = DriverManager.getConnection(url, user, "");
```

### From Go

```go
// Using pgx
import "github.com/jackc/pgx/v5"

conn, err := pgx.Connect(context.Background(), 
    "postgresql://127.0.0.1:5432/devdb")
```

## Configuration

### Create Initial Database and User

Edit `devenv.nix` and uncomment the `initialScript` section:

```nix
initialScript = ''
  CREATE USER myuser WITH PASSWORD 'mypassword';
  CREATE DATABASE myapp OWNER myuser;
  GRANT ALL PRIVILEGES ON DATABASE myapp TO myuser;
'';
```

### Change Port

```nix
services.postgres = {
  enable = true;
  port = 5433;  # Change to different port
  # ...
};
```

### Add Multiple Databases

```nix
initialDatabases = [
  { name = "devdb"; }
  { name = "testdb"; }
  { name = "myapp"; }
];
```

## Background Mode

To run PostgreSQL as a background service:

```bash
devenv up
```

This will start PostgreSQL in the background. You can then connect from your application.

To stop:
```bash
devenv down
```

## Data Persistence

Database data is stored in `.devenv/state/postgres/` directory within the environment. This data persists between shell sessions.

## Tips

- Use different terminal windows: one for database, one for your application
- Or use `devenv up` to run database in background
- Data is persistent - survives shell restarts
- Each database environment is isolated from system PostgreSQL
