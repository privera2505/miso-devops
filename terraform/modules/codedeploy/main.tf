resource "aws_codedeploy_app" "app" {
  compute_platform = "ECS"
  name             = "${var.project_name}-app-${var.environment}"
}

resource "aws_codedeploy_deployment_group" "main" {
  app_name               = aws_codedeploy_app.app.name
  deployment_group_name  = "${var.project_name}-deployment-group-${var.environment}"
  service_role_arn       = var.codedeploy_service_role_arn
  deployment_config_name = "CodeDeployDefault.ECSLinear10PercentEvery1Minutes"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.alb_listener_arn_prod]
      }

      test_traffic_route {
        listener_arns = [var.alb_listener_arn_test]
      }

      target_group {
        name = var.blue_target_group_name
      }

      target_group {
        name = var.green_target_group_name
      }
    }
  }
}
