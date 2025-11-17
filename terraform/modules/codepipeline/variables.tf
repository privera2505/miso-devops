variable "pipeline_name" {
    type = string
}

variable "role_arn" {
    type = string
}

variable "bucket_versiones" {
    type = string
}

variable "codeconnections_arn" {
    type = string
}

variable "source_location" {
    type = string
}

variable "source_version" {
    type = string
}

variable "codebuild_name" {
    type = string
}

variable "codedeploy_app_name" {
    type = string
    description = "Nombre de la aplicación de CodeDeploy"
}

variable "codedeploy_deployment_group" {
    type = string
    description = "Nombre del grupo de despliegue de CodeDeploy"
}

variable "ecs_cluster_name" {
    type = string
    description = "Nombre del cluster ECS"
}

variable "ecs_service_name" {
    type = string
    description = "Nombre del servicio ECS"
}

variable "container_name" {
    type = string
    description = "Nombre del contenedor"
}