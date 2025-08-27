.PHONY: help build build-tomcat build-wildfly run run-tomcat run-wildfly run-compose stop stop-tomcat stop-wildfly clean

# Default target
help:
	@echo "Available targets:"
	@echo "  build          - Build both Tomcat and WildFly images"
	@echo "  build-tomcat   - Build Tomcat image"
	@echo "  build-wildfly  - Build WildFly image"
	@echo "  run            - Run both Tomcat and WildFly containers"
	@echo "  run-compose    - Run full stack with OpenTelemetry Collector"
	@echo "  run-tomcat     - Run Tomcat container on port 8080"
	@echo "  run-wildfly    - Run WildFly container on port 8081"
	@echo "  stop           - Stop compose stack"
	@echo "  stop-tomcat    - Stop Tomcat container"
	@echo "  stop-wildfly   - Stop WildFly container"
	@echo "  clean          - Stop and remove all containers"

# Build targets
build: build-tomcat build-wildfly

build-tomcat:
	@echo "Building Tomcat image..."
	docker build -t tomcat-otel ./tomcat

build-wildfly:
	@echo "Building WildFly image..."
	docker build -t wildfly-otel ./wildfly

# Run targets
run: run-tomcat run-wildfly

run-compose:
	@echo "Starting full stack with OpenTelemetry Collector..."
	docker compose up -d
	@echo "Stack is running:"
	@echo "  Tomcat: http://localhost:8080"
	@echo "  WildFly: http://localhost:8081/demo-app"
	@echo "  OTLP Collector: localhost:4317 (gRPC), localhost:4318 (HTTP)"

run-tomcat:
	@echo "Starting Tomcat container on port 8080..."
	docker run -d -p 8080:8080 --env-file .env --name tomcat-otel-container tomcat-otel
	@echo "Tomcat is running at http://localhost:8080"

run-wildfly:
	@echo "Starting WildFly container on port 8081..."
	docker run -d -p 8081:8080 --env-file .env --name wildfly-otel-container wildfly-otel
	@echo "WildFly is running at http://localhost:8081"

# Stop targets
stop:
	@echo "Stopping compose stack..."
	docker compose down

stop-tomcat:
	@echo "Stopping Tomcat container..."
	-docker stop tomcat-otel-container
	-docker rm tomcat-otel-container

stop-wildfly:
	@echo "Stopping WildFly container..."
	-docker stop wildfly-otel-container
	-docker rm wildfly-otel-container

# Clean up
clean: stop-tomcat stop-wildfly
	@echo "Cleaning up..."
	-docker compose down --rmi all --volumes --remove-orphans
	-docker rmi tomcat-otel wildfly-otel
	-docker rmi otel/opentelemetry-collector-contrib:latest
	@echo "Cleanup complete"
