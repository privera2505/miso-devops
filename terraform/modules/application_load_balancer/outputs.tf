output "alb_arn" {
    value = aws_lb.alb.arn
}

output "sg_id" {
    value = aws_security_group.alb_sg.id
}

output "listener_80_arn" {
    value = aws_lb_listener.http_80.arn
}

output "listener_8080_arn" {
    value = aws_lb_listener.http_8080.arn
}