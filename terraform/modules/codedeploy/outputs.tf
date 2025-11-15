output "app_name" {
  description = "The name of the CodeDeploy application"
  value       = aws_codedeploy_app.app.name
}

output "deployment_group_name" {
  description = "The name of the deployment group"
  value       = aws_codedeploy_deployment_group.main.deployment_group_name
}

output "deployment_group_id" {
  description = "The ID of the deployment group"
  value       = "${aws_codedeploy_app.app.name}:${aws_codedeploy_deployment_group.main.deployment_group_name}"
}
