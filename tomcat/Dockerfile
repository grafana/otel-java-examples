# Minimal Tomcat + OpenTelemetry Java agent
FROM tomcat:9.0.115-jdk8-corretto-al2@sha256:91e15897d3e8d968c0052e24d46b6ec66dccbcbed80221d18ff00af80c4946ba

# (Optional) set timezone; remove if UTC is fine
ENV TZ=Australia/Sydney

# Download Grafana OpenTelemetry Java agent
RUN curl -L -o /usr/local/tomcat/grafana-opentelemetry-java.jar \
  https://github.com/grafana/grafana-opentelemetry-java/releases/latest/download/grafana-opentelemetry-java.jar

# Deploy your WAR(s)
# If you have a single app, you can also copy to ROOT.war
# COPY ./tomcat/ /usr/local/tomcat/webapps/

# OpenTelemetry config (replace placeholders)
ENV JAVA_TOOL_OPTIONS="-javaagent:/usr/local/tomcat/grafana-opentelemetry-java.jar"
ENV OTEL_RESOURCE_ATTRIBUTES="service.name=my-tomcat-app,service.namespace=my-namespace,deployment.environment=production"

ENV OTEL_LOGS_EXPORTER="console"
ENV OTEL_METRICS_EXPORTER="console"
ENV OTEL_TRACES_EXPORTER="console"
ENV OTEL_JAVA_GLOBAL_AUTOCONFIGURE_ENABLED="true"

# Expose only what you use (8443 only if you terminate TLS on Tomcat)
EXPOSE 8080

# Run Tomcat (no custom startup script)
CMD ["catalina.sh", "run"]
