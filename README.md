### Docker Usage

#### Using Pre-built Docker Image

The easiest way to run Version Alert is using the pre-built Docker image:

1. **Start the application:**

   ```bash
   docker-compose up
   ```

2. **Access the application:**
   http://localhost:5173

#### Alternative: Using Docker Run

If you prefer to use Docker directly without docker-compose:

```bash
docker run -d \
  --name version-alert \
  -p 8000:8000 \
  -p 5173:5173 \
  -v server:/app/server \
  -v client:/app/client

```

#### Docker Compose Configuration

For custom deployments, create your own `docker-compose.yaml`:

```yaml
version: "3.8"
services:
  app:
    # image:dor93/version-alert:latest
    build: .
    ports:
      - "8000:8000"
      - "5173:5173"
    volumes:
      - server:/app/server
      - client:/app/client
    environment:
      - NODE_ENV=development

volumes:
  server:
  client:
```

#### Environment Variables

You can customize the application behavior using environment variables:

- `NODE_ENV`: Set to `production` for production deployment
