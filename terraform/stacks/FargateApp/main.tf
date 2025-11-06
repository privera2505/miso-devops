###########################################################
# ECR Module
###########################################################

module "aws_ecr_repository" {
    source = "../../modules/ECR"
    ecr_repository_name = var.ecr_repository_name
}

############################################################
## RDS Module
############################################################
#
#module "rds" {
#    source = "../../modules/rds"
#    identifier = var.identifier
#    username = var.username
#    password = var.password
#    db_name = var.db_name
#}

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
    vpc_id = module.vpc.vpc_id
    target_group_name = var.target_group_name_a
}

module "target_group_b" {
    source = "../../modules/target_groups"
    vpc_id = module.vpc.vpc_id
    target_group_name = var.target_group_name_b
}

###########################################################
# ALB Modules
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

############################################################
## S3 para versiones Module
############################################################
#
#module "s3_bucket_for_versions" {
#    source = "../../modules/s3"
#    environment = var.environment
#    bucket_name = var.s3_bucket_for_versions
#}
#
############################################################
## CodeConnections for github
############################################################
#
#module "connection_github" {
#    source = "../../modules/code_connections_github"
#}
#
############################################################
## IAM CodeBuild
############################################################
#
#module "iam_codebuild" {
#    source = "../../modules/iam_codebuild"
#}
#
############################################################
## Codebuild project configuration
############################################################
#
#module "codebuild_aws" {
#    source = "../../modules/codebuild"
#    build_name = var.build_name
#    iam_codebuild_arn = module.iam_codebuild.codebuild_role_arn
#    ecr_repo_uri = module.aws_ecr_repository.ecr_repo_uri
#    source_location = var.source_location
#    source_type = var.source_type
#    source_version = var.source_version
#    codeconnections_arn = module.connection_github.codeconnettions_arn
#    compute_type = var.compute_type
#    aws_region = var.aws_region
#    bucket_versiones = module.s3_bucket_for_versions.bucket_name
#    db_name = var.db_name
#    db_host = module.rds.db_host
#    username = var.username
#    password = var.password
#}
#
############################################################
## IAM CodePipeline Module
############################################################
#
#module "iam_codepipeline" {
#    source = "../../modules/iam_codepipeline"
#    codeconnections_arn = module.connection_github.codeconnettions_arn
#}
#
############################################################
## CodePipeline Module
############################################################
#
#module "codepipeline_aws" {
#    source = "../../modules/codepipeline"
#    pipeline_name = var.pipeline_name
#    bucket_versiones = module.s3_bucket_for_versions.bucket_name
#    source_location = var.source_location
#    codebuild_name = module.codebuild_aws.project_name
#    codeconnections_arn = module.connection_github.codeconnettions_arn
#    source_version = var.source_version
#    role_arn = module.iam_codepipeline.codepipeline_role_arn
#}