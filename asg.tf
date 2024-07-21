
module "ecs_cloudwatch_autoscaling" {
  source = "cloudposse/ecs-cloudwatch-autoscaling/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace             = "t360-locust"
  stage                 = "staging"
  name                  = "t360-scaling"
  service_name          = module.ecs_service_wrk.name
  cluster_name          = module.ecs_cluster.name
  min_capacity          = 4
  max_capacity          = 20
  scale_up_adjustment   = 2
  scale_up_cooldown     = 60
  scale_down_adjustment = -1
  scale_down_cooldown   = 300
}

module "ecs_cloudwatch_autoscaling_api" {
  source = "cloudposse/ecs-cloudwatch-autoscaling/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace             = "t360-api"
  stage                 = "staging"
  name                  = "t360-scaling"
  service_name          = module.ecs_service_api.name
  cluster_name          = module.ecs_cluster_api.name
  min_capacity          = 5
  max_capacity          = 20
  scale_up_adjustment   = 2
  scale_up_cooldown     = 60
  scale_down_adjustment = -1
  scale_down_cooldown   = 300
}

module "ecs_cloudwatch_autoscaling_api_secondary" {
  source = "cloudposse/ecs-cloudwatch-autoscaling/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace             = "t360-api"
  stage                 = "staging"
  name                  = "t360-scaling"
  service_name          = module.ecs_service_sec.name
  cluster_name          = module.ecs_cluster_sec.name
  min_capacity          = 30
  max_capacity          = 500
  scale_up_adjustment   = 2
  scale_up_cooldown     = 60
  scale_down_adjustment = -1
  scale_down_cooldown   = 300

  providers = {
    aws = aws.region2
  }
}
