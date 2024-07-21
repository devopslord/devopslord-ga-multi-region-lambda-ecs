locals {
  endpoint = module.aurora_postgresql_v2_primary.cluster_instances["one"].endpoint
  identifier = module.aurora_postgresql_v2_primary.cluster_instances["one"].id

  endpoint_reader = module.aurora_postgresql_v2_secondary.cluster_instances["one"].endpoint
  identifier_reader = module.aurora_postgresql_v2_secondary.cluster_instances["one"].id
}

resource "random_password" "master" {
  length  = 20
  special = false
}

resource "aws_secretsmanager_secret" "db_pass" {
  name = "database-terraform_secret-${random_pet.this.id}"
  recovery_window_in_days = 0

}

resource "aws_secretsmanager_secret" "db_pass_region2" {
  name = "database-terraform_secret-${random_pet.this.id}"
  recovery_window_in_days = 0
  provider = aws.region2
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.db_pass.id #remittance
  secret_string = <<EOF
    {
    "password": "${random_password.master.result}", 
    "dbname": "ticket", 
    "engine": "postgres", 
    "port": 5432, 
    "dbInstanceIdentifier": "${local.identifier}", 
    "host": "${local.endpoint}", 
    "username": "t360",
    "endpoint": "postgresql://t360:${random_password.master.result}@${local.endpoint}/ticket"
    }
  EOF
}

resource "aws_secretsmanager_secret_version" "example_2" {
  secret_id     = aws_secretsmanager_secret.db_pass_region2.id 
    provider = aws.region2
  secret_string = <<EOF
    {
    "password": "${random_password.master.result}", 
    "dbname": "ticket", 
    "engine": "postgres", 
    "port": 5432, 
    "dbInstanceIdentifier": "${local.identifier_reader}", 
    "host": "${local.endpoint_reader}", 
    "username": "t360",
    "endpoint": "postgresql://t360:${random_password.master.result}@${local.endpoint_reader}/ticket"
    }
  EOF
}
