##################################################
# build docker image
##################################################


resource "aws_ecr_repository" "this_sec" {
  name                 = "${random_pet.this.id}-fast-api-image"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  provider = aws.region2

  image_scanning_configuration {
    scan_on_push = true
  }
}



# loging to ecr

resource "null_resource" "login-ecr_sec" {
  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region ${var.region2} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region2}.amazonaws.com
    EOT
  }
  
}

resource "null_resource" "tag_image_sec" {
  provisioner "local-exec" {
    command = <<EOT
      docker tag fast_api:latest ${aws_ecr_repository.this_sec.repository_url}:latest
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
  depends_on = [ null_resource.build_api_image_api ]
}

resource "null_resource" "push_image_sec" {
  provisioner "local-exec" {
    command = <<EOT
      docker push ${aws_ecr_repository.this_sec.repository_url}:latest
    EOT
    interpreter = ["PowerShell", "-Command"]
  
  }
  depends_on = [ null_resource.tag_image_sec ]
  
}


module "ecs_cluster_sec" {

  source  = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "~> 5.0"
  depends_on = [ aws_ecr_repository.this_sec ]

  providers = {
    aws  = aws.region2
  }

  cluster_name = "Config360-${random_pet.this.id}-fast_api"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }
}

module "ecs_service_sec" {
  source = "terraform-aws-modules/ecs/aws//modules/service"
  name = "fast_api-svc"
  cluster_arn = module.ecs_cluster_sec.arn

  providers = {
    aws = aws.region2
  }


  load_balancer = {
    service = {
      target_group_arn = module.nlb_sec.target_groups["ex-ip"].arn
      container_name   = "fast_api"
      container_port   = 8080
    }
  }

  subnet_ids                         = module.vpc_secondary.private_subnets
  desired_count                      = 30
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0


  security_group_rules = {
    nlb_ingress_8080 = {
      type                     = "ingress"
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      description              = "Service port"
      cidr_blocks              = ["0.0.0.0/0"]
    }
    nlb_ingress_8080_sg = {
      type                     = "ingress"
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      description              = "Service port"
      source_security_group_id = "${module.nlb_sec.security_group_id}"
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  container_definitions = {
    
    fast_api = {
      requires_compatibilities = ["FARGATE"]
      network_mode             = "awsvpc"
      cpu       = 512
      memory    = 1024
      essential = true
      image     = "${aws_ecr_repository.this_sec.repository_url}"
      port_mappings = [
        {
          name          = "app-port"
          containerPort = 8080
          protocol      = "tcp"
        }
      ]
      secrets = [
        {
            name = "DATABASE_URL"
            valueFrom = "${aws_secretsmanager_secret.db_pass_region2.arn}:endpoint::"
        }
      ]
      enable_cloudwatch_logging = true
      log_configuration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "fast_api-${random_pet.this.id}-task-logs"
          awslogs-region = "${var.region2}"
          awslogs-stream-prefix = "fast_api"
          awslogs-create-group = "true"
        #   log-driver-buffer-limit = "2097152"
        }
      }
    }
  }
}


resource "aws_cloudwatch_log_group" "this_sec" {
  name = "fast_api-${random_pet.this.id}-task-logs"
  retention_in_days = 1

  provider = aws.region2
}
