FROM quay.io/wildfly/wildfly:latest@sha256:3750a1380b99090a4940bcb2763473595d671eedf6afb88c34ca3933231fdbd0

# Download Grafana OpenTelemetry Java agent
RUN curl -L -o /opt/jboss/wildfly/bin/grafana-opentelemetry-java.jar \
  https://github.com/grafana/grafana-opentelemetry-java/releases/latest/download/grafana-opentelemetry-java.jar

# Copy demo app source files
COPY ./demo-app /tmp/demo-app

# Build WAR file during Docker build
RUN cd /tmp && jar -cvf demo-app.war -C demo-app . && \
    mv demo-app.war /opt/jboss/wildfly/standalone/deployments/ && \
    rm -rf /tmp/demo-app || true

# OTel instrumentation (replace placeholders)
ENV JAVA_TOOL_OPTIONS="-javaagent:/opt/jboss/wildfly/bin/grafana-opentelemetry-java.jar"
ENV OTEL_RESOURCE_ATTRIBUTES="service.name=my-wildfly-app,service.namespace=my-namespace,deployment.environment=production"

# (Optional) modest JVM tuning — remove if not needed
ENV JAVA_OPTS="-server -Xms512m -Xmx1024m"

# Expose only what you use
EXPOSE 8080

# Run WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
