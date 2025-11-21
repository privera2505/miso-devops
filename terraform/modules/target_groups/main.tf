resource "aws_lb_target_group" "target_group" {
    name = var.target_group_name
    port = var.container_port
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "ip"

    health_check {
        enabled             = true
        healthy_threshold   = 2
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
        path                = var.health_check_path
        matcher             = "200"
    }
}