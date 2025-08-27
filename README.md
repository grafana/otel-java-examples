# Tomcat & WildFly OpenTelemetry Demo

Demo applications running on Tomcat and WildFly with Grafana OpenTelemetry Java agent instrumentation.

## Quick Start

```bash
# Build both images
make build

# Run both containers
make run

# Access applications
# Tomcat: http://localhost:8080
# WildFly: http://localhost:8081/demo-app

# Clean up
make clean
```

## Available Commands

- `make build` - Build both images
- `make build-tomcat` - Build Tomcat image only
- `make build-wildfly` - Build WildFly image only
- `make run` - Run both containers
- `make run-compose` - Run full stack with OpenTelemetry Collector
- `make run-tomcat` - Run Tomcat only (port 8080)
- `make run-wildfly` - Run WildFly only (port 8081)
- `make stop` - Stop compose stack
- `make stop-tomcat` - Stop Tomcat container
- `make stop-wildfly` - Stop WildFly container
- `make clean` - Stop and remove all containers, images, and volumes

## Configuration

OpenTelemetry settings are configured in `.env` file and loaded automatically when running containers.
