module "container_definition" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "v0.10.0"

  container_name  = "${var.name}"
  container_image = "${var.image == "" ? aws_ecr_repository.application.repository_url : var.image}"

  container_cpu                = "${var.cpu}"
  container_memory_reservation = "${var.memory}"
  container_memory             = ""

  port_mappings = [
    {
      containerPort = "${var.port}"
      hostPort      = 0
      protocol      = "tcp"
    },
  ]

  log_options = [
    {
      "awslogs-region"        = "${data.aws_region.current.name}"
      "awslogs-group"         = "${aws_cloudwatch_log_group.application_logs.name}"
      "awslogs-stream-prefix" = "ecs"
    },
  ]

  healthcheck = {
    command     = ["${var.container_healthcheck_command}"]
    interval    = "${var.container_healthcheck_interval}"
    retries     = "${var.container_healthcheck_retries}"
    startPeriod = "${var.container_healthcheck_startPeriod}"
    timeout     = "${var.container_healthcheck_timeout}"
  }

  environment = ["${var.environment}"]
  secrets     = ["${var.secrets}"]
}
