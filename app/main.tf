terraform {
  backend "s3" {
    bucket                  = "carlsberg-tf-states"
    key                     = "infra/aws/carlsberg-dev-4834-5903-6065/acn-gbs-cxproject-dev-01/dev/cx-initial-service/app/state.tf"
    region                  = "eu-west-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "Carlsberg-Dev"
  }
}

provider "aws" {
  region                    = "eu-west-1"
  shared_credentials_file   = "~/.aws/credentials"
  profile                   = "Carlsberg-Dev"
}

module "nlb" {
  source                   = "git::git@github.com:CarlsbergGBS/carlsberg-infra-source.git//modules/tf_aws_nlb?ref=v1.5"

  application_name         = var.app_name
  vpc_id                   = var.vpc_id
  lb_subnets               = var.private_subnets_ids
  environment              = var.environment
  lb_s3_is_enabled         = var.lb_s3_is_enabled         # automatically creates an s3 bucket for logs
}

module "ecs-task" {
  source                   = "git::git@github.com:CarlsbergGBS/carlsberg-infra-source.git//modules/tf_aws_task?ref=v1.0"
   
  name                     = var.app_name
  environment              = var.environment
  execution_role_arn       = "arn:aws:iam::${var.account}:role/ecsTaskExecutionRole"

  volumes                  = []

  container_definitions = <<EOF
  [
    {
      "dnsSearchDomains": null,
      "logConfiguration": {
        "logDriver": "awslogs",
        "secretOptions": null,
        "options": {
          "awslogs-group": "${var.environment}-task-${var.app_name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${var.app_name}"
        }
      },
      "entryPoint": null,
      "portMappings": [
        {
          "hostPort": 0,
          "protocol": "tcp",
          "containerPort": ${var.container_port_app}
        }
      ],
      "command": null,
      "linuxParameters": null,
      "cpu": 0,
      "memory": 256,
      "environment": [],
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": [],
      "workingDirectory": null,
      "secrets": [],
      "dockerSecurityOptions": null,
      "memory": 256,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image": "${var.registry}${var.image_ecr}:${var.image_tag}",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": null,
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "${var.app_name}"
    }
  ]
  EOF
}

module "ecs-service" {
  source              = "git::git@github.com:CarlsbergGBS/carlsberg-infra-source.git//modules/tf_aws_service?ref=v1.0"

  name                = var.app_name
  cluster_id          = "arn:aws:ecs:${var.region}:${var.account}:cluster/${var.cluster_name}"
  task_definition_arn = "${module.ecs-task.task_definition_arn}"
  servers             = var.num_servers
  tg_arn              = module.nlb.target_group_arn
  container_name      = var.container_name
  container_port      = var.container_port_app
  environment         = var.environment
}
