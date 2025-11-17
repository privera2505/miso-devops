output "cluster_name" {
  value = aws_ecs_cluster.fargate-cluster.name
  description = "Nombre del cluster ECS"
}

output "service_name" {
  value = aws_ecs_service.fargate_service.name
  description = "Nombre del servicio ECS"
}

output "cluster_id" {
  value = aws_ecs_cluster.fargate-cluster.id
  description = "ID del cluster ECS"
}

output "service_id" {
  value = aws_ecs_service.fargate_service.id
  description = "ID del servicio ECS"
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.fargate_task.arn
}