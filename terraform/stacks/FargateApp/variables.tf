###########################################################
# Config Variables
###########################################################

variable "aws_region" {
    description = "La región de AWS donde se desplegarán los recursos."
    type        = string
}

variable "owner" {
    description = "Propietario de los recursos, generalmente el nombre del usuario o equipo."
    type        = string
}

###########################################################
# ECR Variables
###########################################################

variable "ecr_repository_name" {
    description = "Nombre del repositorio de AWS ECR"
    type = string
}

###########################################################
# RDS Variables
###########################################################

variable "identifier" {
    type = string
}

variable "db_name" {
    type = string
}

variable "username" {
    type = string
}

variable "password" {
    type = string
}

###########################################################
# Target Groups Variables
###########################################################

variable "target_group_name_a" {
    type = string
}

variable "target_group_name_b" {
    type = string
}

###########################################################
# ALB Variables
###########################################################

variable "name_security_group" {
    type = string
}

variable "name_lb" {
    type = string
}

###########################################################
# S3 Variables
###########################################################

variable "s3_bucket_for_versions" {
    description = "Nombre del bucket S3"
    type    = string
}

variable "environment" {
    description = "Ambiente del s3"
    type = string
}

###########################################################
# ECS Cluster Variables
###########################################################

variable "cluster_name" {
    description = "Nombre del cluster"
    type = string
}

variable "compute_type_ecs" {
    description = "Tipo de computación del cluster"
    type = string
}

variable "container_name" {
    description = "Nombre del contenedor"
    type = string
}

variable "container_port" {
    description = "Puerto del contenedor"
    type = number
}

###########################################################
# CodeBuild Variables
###########################################################

variable "build_name" {
    type = string
}

variable "compute_type" {
    type = string
}

variable "source_type" {
    type = string
}

variable "source_location" {
    type = string
}

variable "source_version" {
    type = string
}

###########################################################
# CodePipeline Variables
###########################################################

variable "pipeline_name" {
    type = string
}