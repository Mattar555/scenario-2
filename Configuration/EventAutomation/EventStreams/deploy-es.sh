#!/bin/bash


deploy_event_streams() {

  cat <<EOF | oc create -n integration-enablement -f -
  apiVersion: eventstreams.ibm.com/v1beta2
  kind: EventStreams
  metadata:
    name: es-enablement
    labels:
      backup.eventstreams.ibm.com/component: eventstreams
  spec:
    version: latest
    license:
      accept: true
      license: "L-HRZF-DWHH7A"
      use: "EventAutomationNonProduction"
    adminApi: {}
    adminUI: {}
    apicurioRegistry: {}
    collector: {}
    restProducer: {}
    security:
      internalTls: NONE
    strimziOverrides:
      kafka:
        replicas: 1
        config:
          inter.broker.protocol.version: "3.7"
          offsets.topic.replication.factor: 1
          transaction.state.log.min.isr: 1
          transaction.state.log.replication.factor: 1
        listeners:
          - name: plain
            port: 9092
            type: internal
            tls: false
        storage:
          type: ephemeral
        metricsConfig:
          type: jmxPrometheusExporter
          valueFrom:
            configMapKeyRef:
              key: kafka-metrics-config.yaml
              name: light-insecure-metrics-config
      zookeeper:
        replicas: 1
        metricsConfig:
          type: jmxPrometheusExporter
          valueFrom:
            configMapKeyRef:
              key: zookeeper-metrics-config.yaml
              name: light-insecure-metrics-config
        storage:
          type: ephemeral
EOF
}


deploy_event_streams