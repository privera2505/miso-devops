variable "cluster_name" {
    type = string
}

variable "compute_type_ecs" {
    type = string
}

variable "iam_ecs_task" {
    type = string
}

variable "sg_id" {
    type = string
}

variable "subnet_a_id" {
    type = string
}

variable "subnet_b_id" {
    type = string
}

variable "listener_80_arn" {
    type = string
}

variable "container_name" {
    type = string
}

variable "container_port" {
    type = number
}

variable "ecs_service_role" {
    type = string
}

variable "environment" {
    type = string
}

variable "project_name" {
    type = string
}