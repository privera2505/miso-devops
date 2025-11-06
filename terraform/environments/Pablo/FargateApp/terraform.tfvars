###########################################################
# Config Variables
###########################################################
aws_region = "us-east-1"
owner = "priverah"
###########################################################
# ECR Variables
###########################################################
ecr_repository_name = "fargateapp"
###########################################################
# RDS Variables
###########################################################
identifier = "db-postgres-devops"
db_name  = "dbdevops"
username = "postgres"
password = "postgres"
###########################################################
# Target Groups Variables
###########################################################
target_group_name_a = "target-group-1"
target_group_name_b = "target-group-2"
###########################################################
# ALB Variables
###########################################################
name_security_group = "alb-sg"
name_lb = "simplealb"
###########################################################
# S3 Variables
###########################################################
environment = "prod"
s3_bucket_for_versions = "fargate-versions-static"
###########################################################
# Codebuild Variables
###########################################################
build_name = "codebuild_devops"
compute_type = "BUILD_GENERAL1_MEDIUM"
source_type = "CODEPIPELINE"
source_location = "privera2505/miso-devops"
source_version = "feature/codepipeline"
###########################################################
# CodePipeline Variables
###########################################################
pipeline_name = "codepipeline_devops"