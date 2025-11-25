# MySQL Database Environment

Standalone MySQL database environment that can be used with any application.

## What's Included?

- **MySQL 8.0** - latest stable version
- **mysql** - MySQL client
- **mysqldump** - MySQL backup tool
- **mysqladmin** - MySQL administration tool

## How to Use?

### Start the Database

```bash
cd databases/mysql
devenv shell
```

MySQL will start automatically when you enter the shell.

### Connection Details

- **Host**: `127.0.0.1`
- **Port**: `3306`
- **Database**: `devdb` (default)
- **User**: `devuser`
- **Password**: `devpass`

### Common Commands

#### Connect to Database
```bash
mysql -u devuser -p devdb              # Connect (password: devpass)
mysql -u devuser -pdevpass devdb       # Connect without prompt
mysql -h 127.0.0.1 -P 3306 -u devuser -p  # Full connection string
```

#### Database Management
```bash
# List databases
mysql -u devuser -pdevpass -e "SHOW DATABASES;"

# Create database
mysql -u devuser -pdevpass -e "CREATE DATABASE myapp;"

# Drop database
mysql -u devuser -pdevpass -e "DROP DATABASE myapp;"

# Backup database
mysqldump -u devuser -pdevpass devdb > backup.sql

# Restore database
mysql -u devuser -pdevpass devdb < backup.sql
```

#### SQL Queries (inside MySQL shell)
```sql
-- Show databases
SHOW DATABASES;

-- Use database
USE devdb;

-- Show tables
SHOW TABLES;

-- Describe table
DESCRIBE users;

-- Create table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data
INSERT INTO users (name, email) VALUES ('John Doe', 'john@example.com');

-- Query data
SELECT * FROM users;
SELECT * FROM users WHERE name LIKE 'John%';

-- Update data
UPDATE users SET email = 'newemail@example.com' WHERE id = 1;

-- Delete data
DELETE FROM users WHERE id = 1;

-- Drop table
DROP TABLE users;

-- Exit
EXIT;
```

## Using with Applications

### From Node.js/TypeScript

```javascript
// Using mysql2
const mysql = require('mysql2/promise');

const connection = await mysql.createConnection({
  host: '127.0.0.1',
  port: 3306,
  user: 'devuser',
  password: 'devpass',
  database: 'devdb'
});

const [rows] = await connection.execute('SELECT * FROM users');
```

### From Python

```python
# Using mysql-connector-python
import mysql.connector

conn = mysql.connector.connect(
    host='127.0.0.1',
    port=3306,
    user='devuser',
    password='devpass',
    database='devdb'
)

cursor = conn.cursor()
cursor.execute('SELECT * FROM users')
rows = cursor.fetchall()
```

### From Java

```java
// JDBC connection string
String url = "jdbc:mysql://127.0.0.1:3306/devdb";
String user = "devuser";
String password = "devpass";

Connection conn = DriverManager.getConnection(url, user, password);
```

### From Go

```go
// Using go-sql-driver/mysql
import "database/sql"
import _ "github.com/go-sql-driver/mysql"

db, err := sql.Open("mysql", 
    "devuser:devpass@tcp(127.0.0.1:3306)/devdb")
```

## Common Operations

### User Management
```sql
-- Create user
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';

-- Grant privileges
GRANT ALL PRIVILEGES ON devdb.* TO 'newuser'@'localhost';

-- Show grants
SHOW GRANTS FOR 'devuser'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;
```

### Index Management
```sql
-- Create index
CREATE INDEX idx_name ON users(name);

-- Show indexes
SHOW INDEX FROM users;

-- Drop index
DROP INDEX idx_name ON users;
```

### Import/Export
```bash
# Export database
mysqldump -u devuser -pdevpass devdb > devdb_backup.sql

# Export specific table
mysqldump -u devuser -pdevpass devdb users > users_backup.sql

# Export data only (no schema)
mysqldump -u devuser -pdevpass --no-create-info devdb > data.sql

# Export schema only (no data)
mysqldump -u devuser -pdevpass --no-data devdb > schema.sql

# Import
mysql -u devuser -pdevpass devdb < devdb_backup.sql
```

## Configuration

### Change Port

Edit `devenv.nix`:

```nix
services.mysql = {
  enable = true;
  port = 3307;  # Change to different port
  # ...
};
```

### Add More Users

```nix
ensureUsers = [
  {
    name = "devuser";
    password = "devpass";
    ensurePermissions = {
      "devdb.*" = "ALL PRIVILEGES";
    };
  }
  {
    name = "readonly";
    password = "readonly";
    ensurePermissions = {
      "devdb.*" = "SELECT";
    };
  }
];
```

### Create Multiple Databases

```nix
initialDatabases = [
  { name = "devdb"; }
  { name = "testdb"; }
  { name = "myapp"; }
];
```

## Background Mode

To run MySQL as a background service:

```bash
devenv up
```

This will start MySQL in the background. You can then connect from your application.

To stop:
```bash
devenv down
```

## Data Persistence

Database data is stored in `.devenv/state/mysql/` directory within the environment. This data persists between shell sessions.

## Tips

- Use different terminal windows: one for database, one for your application
- Or use `devenv up` to run MySQL in background
- Data is persistent - survives shell restarts
- Each MySQL environment is isolated from system MySQL
- Default credentials are for development only - change for production
- Use transactions for data consistency
- Regular backups are important even in development
