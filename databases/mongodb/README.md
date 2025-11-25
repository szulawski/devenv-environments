# MongoDB Database Environment

Standalone MongoDB database environment that can be used with any application.

## What's Included?

- **MongoDB** - latest stable version
- **mongosh** - MongoDB Shell
- **MongoDB tools** - mongodump, mongorestore, mongoexport, mongoimport

## How to Use?

### Start the Database

```bash
cd databases/mongodb
devenv shell
```

MongoDB will start automatically when you enter the shell.

### Connection Details

- **Host**: `127.0.0.1`
- **Port**: `27017`
- **Connection URI**: `mongodb://127.0.0.1:27017`

### Common Commands

#### Connect to MongoDB
```bash
mongosh                 # Connect to default
mongosh mydb            # Connect to specific database
mongosh "mongodb://127.0.0.1:27017/mydb"  # Full URI
```

#### Database Operations (in mongosh)
```javascript
// Show databases
show dbs

// Switch to database (creates if doesn't exist)
use mydb

// Show collections
show collections

// Insert document
db.users.insertOne({ name: "John", age: 30 })

// Find documents
db.users.find()
db.users.findOne({ name: "John" })

// Update document
db.users.updateOne(
  { name: "John" },
  { $set: { age: 31 } }
)

// Delete document
db.users.deleteOne({ name: "John" })

// Drop collection
db.users.drop()

// Drop database
db.dropDatabase()
```

#### Backup and Restore
```bash
# Backup entire database
mongodump --db mydb --out ./backup

# Restore database
mongorestore --db mydb ./backup/mydb

# Export collection to JSON
mongoexport --db mydb --collection users --out users.json

# Import collection from JSON
mongoimport --db mydb --collection users --file users.json
```

## Using with Applications

### From Node.js/TypeScript

```javascript
// Using mongodb native driver
const { MongoClient } = require('mongodb');

const client = new MongoClient('mongodb://127.0.0.1:27017');

await client.connect();
const db = client.db('mydb');
const users = db.collection('users');

await users.insertOne({ name: 'John', age: 30 });
const user = await users.findOne({ name: 'John' });
```

```javascript
// Using Mongoose
const mongoose = require('mongoose');

await mongoose.connect('mongodb://127.0.0.1:27017/mydb');

const UserSchema = new mongoose.Schema({
  name: String,
  age: Number
});

const User = mongoose.model('User', UserSchema);
```

### From Python

```python
# Using pymongo
from pymongo import MongoClient

client = MongoClient('mongodb://127.0.0.1:27017/')
db = client.mydb
users = db.users

users.insert_one({'name': 'John', 'age': 30})
user = users.find_one({'name': 'John'})
```

### From Java

```java
// Using MongoDB Java Driver
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoDatabase;

MongoClient mongoClient = MongoClients.create("mongodb://127.0.0.1:27017");
MongoDatabase database = mongoClient.getDatabase("mydb");
MongoCollection<Document> collection = database.getCollection("users");
```

### From Go

```go
// Using mongo-go-driver
import "go.mongodb.org/mongo-driver/mongo"

client, err := mongo.Connect(ctx, 
    options.Client().ApplyURI("mongodb://127.0.0.1:27017"))

collection := client.Database("mydb").Collection("users")
```

## Useful mongosh Commands

```javascript
// Database stats
db.stats()

// Collection stats
db.users.stats()

// Index management
db.users.createIndex({ name: 1 })
db.users.getIndexes()
db.users.dropIndex("name_1")

// Aggregation
db.users.aggregate([
  { $match: { age: { $gte: 18 } } },
  { $group: { _id: "$status", count: { $sum: 1 } } }
])

// Count documents
db.users.countDocuments()
db.users.countDocuments({ age: { $gte: 18 } })

// Distinct values
db.users.distinct("age")
```

## Configuration

### Change Port

Edit `devenv.nix`:

```nix
services.mongodb = {
  enable = true;
  additionalArgs = [ "--port" "27018" ];
};
```

### Enable Quiet Mode

```nix
services.mongodb = {
  enable = true;
  additionalArgs = [ "--quiet" ];
};
```

## Background Mode

To run MongoDB as a background service:

```bash
devenv up
```

This will start MongoDB in the background. You can then connect from your application.

To stop:
```bash
devenv down
```

## Data Persistence

Database data is stored in `.devenv/state/mongodb/` directory within the environment. This data persists between shell sessions.

## Tips

- Use different terminal windows: one for database, one for your application
- Or use `devenv up` to run MongoDB in background
- Data is persistent - survives shell restarts
- Great for document-based applications and rapid prototyping
- Each MongoDB environment is isolated from system MongoDB
- Use indexes for better query performance
- MongoDB Shell (mongosh) supports JavaScript syntax
