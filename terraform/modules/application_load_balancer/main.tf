###########################################
# Security Groups
###########################################
resource "aws_security_group" "alb_sg" {
    name        = var.name_security_group
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

###########################################
# Load Balancer
###########################################
resource "aws_lb" "alb" {
    name               = var.name_lb
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = [
        var.subnet_a_id,
        var.subnet_b_id
    ]
    tags = { Name = var.name_lb }
}

###########################################
# Listeners y direccionamiento por puerto
###########################################
resource "aws_lb_listener" "http_80" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = var.tg_a
    }
}

resource "aws_lb_listener" "http_8080" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 8080
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = var.tg_b
    }
}
