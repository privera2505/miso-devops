resource "aws_iam_role" "ecs_service_role" {
    name = "ecsServiceRole"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Effect = "Allow",
            Principal = {
            Service = "ecs.amazonaws.com"
            },
            Action = "sts:AssumeRole"
        }
        ]
    })
}