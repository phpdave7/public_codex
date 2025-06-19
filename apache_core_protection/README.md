# Apache Core Dump Protection Example

This example demonstrates how to configure Apache so that core dump files cannot be downloaded. The `Dockerfile` builds a container running Apache with a custom configuration in `httpd.conf` that denies access to files starting with `core`.

## Usage

```bash
# build and run tests (requires Docker)
./run_tests.sh
```

The server exposes a simple `index.html` page while `core.1234` and `core.dump` are present in the document root but should return `403 Forbidden` when requested.
