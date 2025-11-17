###########################################################
# ECR Module
###########################################################

module "aws_ecr_repository" {
    source = "../../modules/ECR"
    ecr_repository_name = var.ecr_repository_name
}

###########################################################
# RDS Module
###########################################################

module "rds" {
    source = "../../modules/rds"
    identifier = var.identifier
    username = var.username
    password = var.password
    db_name = var.db_name
}

###########################################################
# VPC Module
###########################################################

module "vpc" {
    source = "../../modules/vpc"
}

###########################################################
# Targets_Groups Modules
###########################################################

module "target_group_a" {
    source = "../../modules/target_groups"
    container_port = var.container_port
    vpc_id = module.vpc.vpc_id
    target_group_name = var.target_group_name_a
}

module "target_group_b" {
    source = "../../modules/target_groups"
    container_port = var.container_port
    vpc_id = module.vpc.vpc_id
    target_group_name = var.target_group_name_b
}

###########################################################
# ALB Module
###########################################################

module "alb" {
    source = "../../modules/application_load_balancer"
    vpc_id = module.vpc.vpc_id
    name_lb = var.name_lb
    name_security_group = var.name_security_group
    subnet_a_id = module.vpc.subnet_a_id
    subnet_b_id = module.vpc.subnet_b_id
    tg_a = module.target_group_a.target_group_arn
    tg_b = module.target_group_b.target_group_arn
}

###########################################################
# IAM ECS Module
###########################################################

module "iam_ecs" {
    source = "../../modules/iam_ecs"
}

###########################################################
# IAM ECS service role Module
###########################################################

module "iam_ecs_servicerole" {
    source = "../../modules/iam_ecs_servicerole"
}

###########################################################
# ECS Cluster Module
###########################################################

module "ecs_cluster" {
    source = "../../modules/ecs"
    cluster_name = var.cluster_name
    compute_type_ecs = var.compute_type_ecs
    iam_ecs_task = module.iam_ecs.iam_ecs_arn
    sg_id = module.alb.sg_id
    subnet_a_id = module.vpc.subnet_a_id
    subnet_b_id = module.vpc.subnet_b_id
    listener_80_arn = module.target_group_a.target_group_arn
    container_name = var.container_name
    container_port = var.container_port
    ecs_service_role = module.iam_ecs_servicerole.ecsservicerole_arn
    project_name = var.project_name
    environment = var.environment
}

###########################################################
# S3 para versiones Module
###########################################################

module "s3_bucket_for_versions" {
    source = "../../modules/s3"
    environment = var.environment
    bucket_name = var.s3_bucket_for_versions
}

#############################################################
## CodeConnections for github
############################################################
#
module "connection_github" {
   source = "../../modules/code_connections_github"
}

###########################################################
# IAM CodeBuild
###########################################################

module "iam_codebuild" {
    source = "../../modules/iam_codebuild"
}

###########################################################
# Codebuild project configuration
###########################################################

module "codebuild_aws" {
    source = "../../modules/codebuild"
    build_name = var.build_name
    iam_codebuild_arn = module.iam_codebuild.codebuild_role_arn
    ecr_repo_uri = module.aws_ecr_repository.ecr_repo_uri
    source_location = var.source_location
    source_type = var.source_type
    source_version = var.source_version
    codeconnections_arn = module.connection_github.codeconnettions_arn
    compute_type = var.compute_type
    aws_region = var.aws_region
    bucket_versiones = module.s3_bucket_for_versions.bucket_name
    db_name = var.db_name
    db_host = module.rds.db_host
    username = var.username
    password = var.password
    container_name = var.container_name
    container_port = var.container_port
    task_role_arn = module.iam_ecs.iam_ecs_arn
    execution_role_arn = module.iam_ecs_servicerole.ecsservicerole_arn
    task_definition_arn = module.ecs_cluster.task_definition_arn
}

###########################################################
# IAM CodePipeline Module
###########################################################

module "iam_codepipeline" {
    source = "../../modules/iam_codepipeline"
    codeconnections_arn = module.connection_github.codeconnettions_arn
}

###########################################################
# CodeDeploy Module
###########################################################

module "codedeploy_aws" {
    source = "../../modules/codedeploy"
    project_name = var.project_name
    environment = var.environment
    codedeploy_service_role_arn = module.iam_codedeploy.codedeploy_service_role_arn
    ecs_cluster_name = module.ecs_cluster.cluster_name
    ecs_service_name = module.ecs_cluster.service_name
    alb_listener_arn_prod = module.alb.listener_80_arn
    alb_listener_arn_test = module.alb.listener_8080_arn
    blue_target_group_name = module.target_group_a.target_group_name
    green_target_group_name = module.target_group_b.target_group_name
}

###########################################################
# IAM CodeDeploy Module
###########################################################

module "iam_codedeploy" {
    source = "../../modules/iam_codedeploy"
}

###########################################################
# CodePipeline Module
###########################################################

module "codepipeline_aws" {
    source = "../../modules/codepipeline"
    pipeline_name = var.pipeline_name
    bucket_versiones = module.s3_bucket_for_versions.bucket_name
    source_location = var.source_location
    codebuild_name = module.codebuild_aws.project_name
    codeconnections_arn = module.connection_github.codeconnettions_arn
    source_version = var.source_version
    role_arn = module.iam_codepipeline.codepipeline_role_arn
    container_name = var.container_name
    codedeploy_app_name = module.codedeploy_aws.app_name
    ecs_cluster_name = module.ecs_cluster.cluster_name
    ecs_service_name = module.ecs_cluster.service_name
    codedeploy_deployment_group = module.codedeploy_aws.deployment_group_name
}