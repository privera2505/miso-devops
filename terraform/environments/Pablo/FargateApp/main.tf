terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

module "fargate_app" {
  source = "../../../stacks/FargateApp"

  # Config Variables
  aws_region = var.aws_region
  owner = var.owner

  # ECR Variables
  ecr_repository_name = var.ecr_repository_name

  # RDS Variables
  identifier = var.identifier
  db_name = var.db_name
  username = var.username
  password = var.password

  # Target Groups Variables
  target_group_name_a = var.target_group_name_a
  target_group_name_b = var.target_group_name_b

  # ALB Variables
  name_security_group = var.name_security_group
  name_lb = var.name_lb

  # ECS Cluster Variables
  cluster_name = var.cluster_name
  compute_type_ecs = var.compute_type_ecs
  container_name = var.container_name
  container_port = var.container_port

  # S3 Variables
  environment = var.environment
  s3_bucket_for_versions = var.s3_bucket_for_versions

  # CodeBuild Variables
  build_name = var.build_name
  compute_type = var.compute_type
  source_type = var.source_type
  source_location = var.source_location
  source_version = var.source_version

  # CodePipeline Variables
  pipeline_name = var.pipeline_name

  # CodeDeploy Variables (NUEVO)
  project_name = var.project_name
}