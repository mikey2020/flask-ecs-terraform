resource "aws_ecr_repository" "blog-app-repo" {
  name                 = "blog-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecs_cluster" "blog-app-cluster" {
  name = "blog-app-cluster"
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "blog-app-logs"

  tags = {
    Application = "blog-app"
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "blog-app-task"

  container_definitions = <<DEFINITION
  [
    {
      "name": "blog-app-container",
      "image": "${aws_ecr_repository.blog-app-repo.repository_url}:latest",
      "entryPoint": [],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "us-east-2",
          "awslogs-stream-prefix": "blog-app"
        }
      },
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080
        }
      ],
      "cpu": 256,
      "memory": 512
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "ecs-blog-app" {
  name = "ecs-blog-app"
  cluster = aws_ecs_cluster.blog-app-cluster.arn
  task_definition = aws_ecs_task_definition.aws-ecs-task.arn
  desired_count = 2
 }

