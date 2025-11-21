###########################################
# Security Groups
###########################################
#Aplication load balancer
resource "aws_security_group" "alb_sg" {
    name        = var.name_security_group
    description = "Security group para Application Load Balancer"
    vpc_id      = var.vpc_id

    # Permitir tráfico HTTP en puerto 80 (Blue)
    ingress {
        description = "HTTP from Internet"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Permitir tráfico HTTP en puerto 8080 (Green - Test)
    ingress {
        description = "HTTP Test from Internet"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
#Para la ecs Task
resource "aws_security_group" "ecs_task_sg" {
    name        = "${var.project_name}-${var.environment}-ecs-tasks-sg"
    description = "Security group para ECS Tasks"
    vpc_id = var.vpc_id

    # Permitir tráfico desde el ALB en el puerto de la aplicación
    ingress {
        description     = "Allow traffic from ALB"
        from_port       = var.app_port
        to_port         = var.app_port
        protocol        = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

    # Permitir todo el tráfico saliente
    egress {
        description = "Allow all outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-ecs-tasks-sg"
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
    enable_http2 = true
    idle_timeout = 60
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
