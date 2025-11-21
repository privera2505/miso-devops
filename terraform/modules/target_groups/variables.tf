variable "target_group_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "container_port" {
    type = number
}

variable "health_check_path" {
    type = string
}