# GitHub Actions ECS Deployment Example

This example demonstrates a simple CI/CD pipeline using GitHub Actions to deploy a containerized application to AWS ECS.

The `Dockerfile` builds a small Python web service. The GitHub Actions workflow builds the container image, pushes it to Amazon ECR, and updates an ECS service. Pushes to the **develop** branch deploy to the **dev** environment, while pushes to **main** deploy to **prod**. Create GitHub environments with these names to store your AWS credentials.

## Usage (Docker)

Build and start the sample service locally:

```bash
docker-compose up --build -d
./run_tests.sh
docker-compose down
```

## GitHub Actions

The workflow file is located at `.github/workflows/deploy.yml`. Create GitHub environments named `dev` and `prod`, each containing these secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `ECR_REPOSITORY`
- `ECS_CLUSTER`
- `ECS_SERVICE_BASE` (the service name will be `<base>-dev` or `<base>-prod`)
- `TASK_DEFINITION` (ARN or family name of the task definition to run)
- `ECS_SUBNETS` (comma-separated subnet IDs)
- `ECS_SECURITY_GROUPS` (comma-separated security group IDs)

The workflow logs in to ECR, builds and pushes the Docker image, then ensures both the ECS cluster and service exist before deploying.
If the cluster doesn't exist it will be created automatically, and the service will be created using the subnets and security groups you provide if needed.
It also prints helpful debugging information such as the branch name, selected environment, and image tag so you can verify the pipeline configuration.
