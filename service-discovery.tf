resource "aws_service_discovery_private_dns_namespace" "private" {
  name        = "t360-load-testing.test"
  description = "Private dns namespace for service discovery"
  vpc         = module.vpc.vpc_id
}

resource "aws_service_discovery_service" "this" {
  name = "locust-master"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.private.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "worker" {
  name = "locust-wkr"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.private.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
