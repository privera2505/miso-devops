resource "aws_iam_role" "ecs_service_role" {
    name = "ecsServiceRole"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Effect = "Allow",
            Principal = {
            Service = "ecs-tasks.amazonaws.com"
            },
            Action = "sts:AssumeRole"
        }
        ]
    })
}

#Politica personalizada para acceso a recursos AWS.
resource "aws_iam_role_policy" "ecs_task_policy" {
    name = "ecs-task-policy"
    role = aws_iam_role.ecs_service_role.id

    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ]
            Resource = "*"
        }
        ]
    })
}