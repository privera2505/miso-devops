###########################################################
# ECR Outputs
###########################################################
output "aws_ecr_repository_uri" {
    value = module.aws_ecr_repository.ecr_repo_uri
}