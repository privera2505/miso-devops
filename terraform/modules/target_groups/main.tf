resource "aws_lb_target_group" "target_group" {
    name = var.target_group_name
    port = var.container_port
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "ip"
}