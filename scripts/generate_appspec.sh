#!/bin/bash

set -e

if [[ -z "$TASK_DEFINITION_ARN" ]]; then
  echo "❌ TASK_DEFINITION_ARN está vacío."
  exit 1
fi

if [[ -z "$CONTAINER_NAME" ]]; then
  echo "❌ CONTAINER_NAME está vacío."
  exit 1
fi

cat > appspec.yml <<EOF
version: 0.0
Resources:
  - TargetService:
      Type: AWS::ECS::Service
      Properties:
        TaskDefinition: ${TASK_DEFINITION_ARN}
        LoadBalancerInfo:
          ContainerName: ${CONTAINER_NAME}
          ContainerPort: 8000
Hooks:
  - BeforeInstall:
      location: scripts/before_install.sh
      timeout: 300
      runas: root
  - Install:
      location: scripts/install.sh
      timeout: 300
      runas: root
  - AfterInstall:
      location: scripts/after_install.sh
      timeout: 300
      runas: root
  - AllowTraffic:
      location: scripts/allow_traffic.sh
      timeout: 300
      runas: root
EOF
