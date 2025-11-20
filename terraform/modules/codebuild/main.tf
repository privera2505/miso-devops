resource "aws_codebuild_project" "docker_build" {
    name          = var.build_name
    description   = "Builds Docker image and pushes it to ECR"
    service_role  = var.iam_codebuild_arn

    artifacts {
        type = var.source_type
    }

    environment {
        compute_type                = var.compute_type
        image                       = "aws/codebuild/standard:7.0"
        type                        = "LINUX_CONTAINER"
        privileged_mode             = true
        image_pull_credentials_type = "CODEBUILD"

        environment_variable {
            name  = "AWS_DEFAULT_REGION"
            value = var.aws_region
        }

        environment_variable {
            name  = "ECR_REPO_URI"
            value = var.ecr_repo_uri
        }
        
        environment_variable{ 
            name =  "DB_USER"
            value = var.username
        }
        
        environment_variable{ 
            name =  "DB_PASSWORD"
            value = var.password
        }
        
        environment_variable{ 
            name =  "DB_NAME"
            value = var.db_name
        }
        
        environment_variable{ 
            name =  "DB_HOST"
            value = var.db_host
        }

        environment_variable {
            name = "CONTAINER_NAME"
            value = var.container_name
        }

        environment_variable {
            name = "EXECUTION_ROLE_ARN"
            value = var.execution_role_arn
        }

        environment_variable {
            name = "TASK_ROLE_ARN"
            value = var.task_role_arn
        }

        environment_variable {
            name = "CONTAINER_PORT"
            value = var.container_port
        }
    }  


    source {
        type      = var.source_type
        #location  = var.source_location
        #buildspec = "buildspec.yml"
        #git_clone_depth = 1
        #
        #git_submodules_config {
        #    fetch_submodules = true
        #}
        #
        #auth {
        #    type = "CODECONNECTIONS"
        #    resource = var.codeconnections_arn
        #}

    }

    source_version = var.source_version

    logs_config {
        cloudwatch_logs {
        group_name  = "/aws/codebuild/${var.build_name}"
        stream_name = "${var.build_name}-stream"
        }
    }

    tags = {
        CreatedBy = "terraform"
    }
}