# Redis Cache Environment

Standalone Redis cache/message broker environment that can be used with any application.

## What's Included?

- **Redis** - latest stable version
- **redis-cli** - Redis command-line client
- **redis-server** - Redis server

## How to Use?

### Start Redis

```bash
cd databases/redis
devenv shell
```

Redis will start automatically when you enter the shell.

### Connection Details

- **Host**: `127.0.0.1`
- **Port**: `6379`
- **Password**: None (no authentication by default)

### Common Commands

#### Connect and Test
```bash
redis-cli               # Connect to Redis
redis-cli ping          # Test connection (should return PONG)
redis-cli info          # Server information
redis-cli monitor       # Monitor all commands in real-time
```

#### Basic Operations
```bash
# Set/Get values
redis-cli SET mykey "Hello World"
redis-cli GET mykey
redis-cli DEL mykey

# Lists
redis-cli LPUSH mylist "item1"
redis-cli LPUSH mylist "item2"
redis-cli LRANGE mylist 0 -1

# Check all keys
redis-cli KEYS "*"

# Flush all data
redis-cli FLUSHALL
```

## Using with Applications

### From Node.js/TypeScript

```javascript
// Using ioredis
const Redis = require('ioredis');

const redis = new Redis({
  host: '127.0.0.1',
  port: 6379,
});

await redis.set('key', 'value');
const value = await redis.get('key');
```

### From Python

```python
# Using redis-py
import redis

r = redis.Redis(
    host='127.0.0.1',
    port=6379,
    decode_responses=True
)

r.set('key', 'value')
value = r.get('key')
```

### From Java

```java
// Using Jedis
import redis.clients.jedis.Jedis;

Jedis jedis = new Jedis("127.0.0.1", 6379);
jedis.set("key", "value");
String value = jedis.get("key");
```

### From Go

```go
// Using go-redis
import "github.com/redis/go-redis/v9"

rdb := redis.NewClient(&redis.Options{
    Addr: "127.0.0.1:6379",
})

err := rdb.Set(ctx, "key", "value", 0).Err()
val, err := rdb.Get(ctx, "key").Result()
```

## Common Use Cases

### Caching
```bash
# Cache with expiration (60 seconds)
redis-cli SETEX cache_key 60 "cached value"
redis-cli TTL cache_key  # Check remaining time
```

### Session Storage
```bash
# Store session
redis-cli HSET session:user123 name "John" email "john@example.com"
redis-cli HGETALL session:user123
```

### Message Queue (Pub/Sub)
```bash
# Terminal 1 - Subscribe
redis-cli SUBSCRIBE mychannel

# Terminal 2 - Publish
redis-cli PUBLISH mychannel "Hello subscribers!"
```

### Rate Limiting
```bash
# Count requests
redis-cli INCR user:123:requests
redis-cli EXPIRE user:123:requests 60
redis-cli GET user:123:requests
```

## Configuration

### Change Port

Edit `devenv.nix`:

```nix
services.redis = {
  enable = true;
  port = 6380;  # Change to different port
};
```

### Add Password Authentication

```nix
services.redis = {
  enable = true;
  port = 6379;
  requirePass = "mysecretpassword";
};
```

### Increase Memory Limit

```nix
services.redis = {
  enable = true;
  port = 6379;
  extraConfig = ''
    maxmemory 256mb
    maxmemory-policy allkeys-lru
  '';
};
```

## Background Mode

To run Redis as a background service:

```bash
devenv up
```

This will start Redis in the background. You can then connect from your application.

To stop:
```bash
devenv down
```

## Data Persistence

By default, Redis stores data in memory. Data is persisted to disk in `.devenv/state/redis/` and will survive restarts.

## Monitoring

```bash
# Real-time stats
redis-cli --stat

# Monitor all commands
redis-cli monitor

# Get info about memory usage
redis-cli INFO memory

# Get info about all sections
redis-cli INFO all
```

## Tips

- Use different terminal windows: one for Redis, one for your application
- Or use `devenv up` to run Redis in background
- Data persists between shell sessions
- Perfect for development caching, sessions, and message queues
- Each Redis environment is isolated from system Redis
