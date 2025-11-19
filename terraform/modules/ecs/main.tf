#ECS Cluster
resource "aws_ecs_cluster" "fargate-cluster" {
    name = var.cluster_name

    setting {
        name  = "containerInsights"
        value = "enabled"
    }

}

resource "aws_ecs_cluster_capacity_providers" "fargate_providers" {
    cluster_name = aws_ecs_cluster.fargate-cluster.name
    capacity_providers = [var.compute_type_ecs]

    default_capacity_provider_strategy {
        capacity_provider = var.compute_type_ecs
        weight = 1
    }
}

#Task
resource "aws_ecs_task_definition" "fargate_task" {
    family                   = "${var.project_name}-${var.environment}-task"
    requires_compatibilities  = [var.compute_type_ecs]
    network_mode              = "awsvpc"
    cpu                       = 1024       
    memory                    = 3072       
    execution_role_arn        = var.iam_ecs_task
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
    }

    # Contenedor aún no definido, será reemplazado por CodePipeline/CodeBuild
    container_definitions = jsonencode([
        {
        name      = var.container_name
        image     = "public.ecr.aws/docker/library/python:3-alpine" # dummy temporal
        essential = true
        command   = ["python3", "-m", "http.server", tostring(var.container_port)],
        cpu       = 10
        memory    = 256
        portMappings = [
            {
                containerPort = var.container_port,
                protocol = "tcp"
            }
        ]
        }
    ])

    tags = {
        Name        = "app-fargate-task"
        Environment = "dev"
    }
}

#Service
resource "aws_ecs_service" "fargate_service" {
    name = "${var.project_name}-${var.environment}-service"
    cluster = aws_ecs_cluster.fargate-cluster.id
    task_definition = aws_ecs_task_definition.fargate_task.arn
    launch_type = var.compute_type_ecs
    desired_count = 1

    deployment_controller {
        type = "CODE_DEPLOY"
    }

    network_configuration {
        assign_public_ip = true
        subnets = [ 
            var.subnet_a_id,
            var.subnet_b_id
        ]
        security_groups = [ var.sg_id ]
    }

    load_balancer {
        target_group_arn = var.listener_80_arn
        container_name = var.container_name
        container_port = var.container_port
    }

    lifecycle {
        ignore_changes = [ 
            task_definition,
            desired_count,
            load_balancer
        ]
    }

}