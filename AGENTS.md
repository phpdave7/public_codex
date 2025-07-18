# Repository Guidelines

This repository contains a collection of example projects generated for various requests. Each distinct request should be organized into its own folder at the repository root. Expect many different folders, each representing an independent example or proof of concept.

When responding to new requests, the agent should create or choose a folder whose name reflects the context of the request, and place all related files inside that folder.

Each example folder must include a `docker-compose.yml` so that running `docker-compose up --build` will start the example environment. The test scripts assume the corresponding compose service is already running.

### IBM i PASE (PUB400.com)

Include a `pub400` subfolder **only** when the request specifically involves IBM i or IBM i PASE. AWS-focused examples should not contain a `pub400` folder.

