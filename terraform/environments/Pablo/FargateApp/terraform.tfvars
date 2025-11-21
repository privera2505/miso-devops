###########################################################
# Config Variables
###########################################################
aws_region = "us-east-1"
owner = "priverah"
project_name = "fargateapp"
environment = "prod"
###########################################################
# ECR Variables
###########################################################
ecr_repository_name = "fargateapp"

###########################################################
# RDS Variables (usar la misma BD existente)
###########################################################
identifier = "db-postgres-devops"
db_name = "dbdevops"
username = "postgres"
password = "postgres"

###########################################################
# Target Groups Variables
###########################################################
target_group_name_a = "target-group-1"
target_group_name_b = "target-group-2"
health_check_path = "/"

###########################################################
# ALB Variables
###########################################################
name_security_group = "alb-sg"
name_lb = "simplealb"

###########################################################
# ECS Cluster Variables
###########################################################
cluster_name = "fargatecluster"
compute_type_ecs = "FARGATE"
container_name = "appcontainer"
container_port = 8000

###########################################################
# S3 Variables
###########################################################
s3_bucket_for_versions = "fargate-versions-static"
###########################################################
# Codebuild Variables
###########################################################
build_name = "codebuild_devops"
compute_type = "BUILD_GENERAL1_MEDIUM"
source_type = "CODEPIPELINE"
source_location = "privera2505/miso-devops"
source_version = "feature/fargate"

###########################################################
# CodePipeline Variables
###########################################################
pipeline_name = "codepipeline_devops"