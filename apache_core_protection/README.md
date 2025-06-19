# Apache Core Dump Protection Example

This example demonstrates how to configure Apache so that core dump files cannot be downloaded. The `Dockerfile` adds a small configuration snippet that is included in Apache's default `httpd.conf` to deny access to files starting with `core`.

## Usage (Docker)

Build and start the example using Docker Compose, then run the tests:

```bash
docker-compose up --build -d
./run_tests.sh
docker-compose down
```

The server exposes a simple `index.html` page while `core.1234` and `core.dump` are present in the document root but should return `403 Forbidden` when requested.

## Running on IBM i (PUB400)

See the [pub400](./pub400) folder for a helper script that copies the sample files to your PUB400 account and starts Apache in the PASE environment.

