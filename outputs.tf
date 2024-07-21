output "function_url" {
  value = module.Create_blogs_Table.lambda_function_url
}

output "create_payments_table" {
    value = "${var.domain_name}/create-payments-lambda-db-table"
}

output "create_sqs_table" {
    value = "${var.domain_name}/create-lambda-sqs-db-table"
}

output "locust_endpoint" {
  value = module.alb_load.dns_name
}