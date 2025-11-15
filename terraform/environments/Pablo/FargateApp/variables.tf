variable "aws_region" {
  description = "AWS region"
  type = string
}

variable "owner" {
  description = "Owner of resources"
  type = string
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type = string
}

variable "identifier" {
  description = "RDS identifier"
  type = string
}

variable "db_name" {
  description = "Database name"
  type = string
}

variable "username" {
  description = "Database username"
  type = string
}

variable "password" {
  description = "Database password"
  type = string
}

variable "target_group_name_a" {
  description = "Target group A name"
  type = string
}

variable "target_group_name_b" {
  description = "Target group B name"
  type = string
}

variable "name_security_group" {
  description = "Security group name"
  type = string
}

variable "name_lb" {
  description = "Load balancer name"
  type = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type = string
}

variable "compute_type_ecs" {
  description = "ECS compute type"
  type = string
}

variable "container_name" {
  description = "Container name"
  type = string
}

variable "container_port" {
  description = "Container port"
  type = number
}

variable "environment" {
  description = "Environment"
  type = string
}

variable "s3_bucket_for_versions" {
  description = "S3 bucket for versions"
  type = string
}

variable "build_name" {
  description = "CodeBuild project name"
  type = string
}

variable "compute_type" {
  description = "CodeBuild compute type"
  type = string
}

variable "source_type" {
  description = "Source type"
  type = string
}

variable "source_location" {
  description = "Source location"
  type = string
}

variable "source_version" {
  description = "Source version"
  type = string
}

variable "pipeline_name" {
  description = "CodePipeline name"
  type = string
}

variable "project_name" {
  description = "Project name for CodeDeploy"
  type = string
}