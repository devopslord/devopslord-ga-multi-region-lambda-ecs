module "lambda_primary" { # loadbalancer guy here!
  source = "terraform-aws-modules/lambda/aws"

  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/dev/GET/get-region"
    }
  }


  function_name = "Website-global-accelerator"
  description   = "Serves as the root handler behind the Web ALB"  
  handler       = "main.lambda_handler"
  runtime       = "python3.11"
  architectures = ["x86_64"]
  timeout       = 60
  tracing_mode  = "PassThrough"
  publish       = true
  store_on_s3   = false
  memory_size   = 128

  source_path = "${path.module}/src/demo/"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

  environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   attach_policies    = true
   number_of_policies = 2
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "src/python-layer.zip"
  layer_name = "t360-layer"

  compatible_runtimes = ["python3.11", "python3.9", "python3.10", "python3.8"]
}

module "CreatepaymentTableLambdaFunction" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "tf-CreatepaymentTable"
  handler       = "api.create_payment_table"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/Api/"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

   attach_policy_statements = true


   environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   policy_statements = {
     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "Create_blogs_Table" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "Create_fast-api_Table"
  handler       = "api.blogs_table"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  create_lambda_function_url = true
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024


  source_path = "${path.module}/src/Api"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

  environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
  }

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

   attach_policy_statements = true
   policy_statements = {
     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}

module "DroppaymentTableLambdaFunction" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "tf-DroppaymentTable"
  handler       = "api.drop_payment_table"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/Api/"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

   environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   attach_policy_statements = true
   policy_statements = {

     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "GetpaymentsLambdaFunction" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "tf-Getpayments"
  handler       = "api.get_payments"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024
  provisioned_concurrent_executions = 2000

  source_path = "${path.module}/src/Api/"


  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

   environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   attach_policy_statements = true
   policy_statements = {

    secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "CreatepaymentLambdaFunction" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "tf-Createpayment"
  handler       = "api.create_payment"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/Api/"

    provisioned_concurrent_executions = 2000
  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

  environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   attach_policy_statements = true
   policy_statements = {

     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "UpdatepaymentLambdaFunction" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "tf-Updatepayment"
  handler       = "api.update_payment"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/Api/"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

      environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   attach_policy_statements = true
   policy_statements = {

     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}

module "DeletepaymentLambdaFunction" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "tf-Deletepayment"
  handler       = "api.delete_payment"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/Api/"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

      environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   attach_policy_statements = true
   policy_statements = {

     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "ClearpaymentsLambdaFunction" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "tf-Clearpayments"
  handler       = "api.clear_payments"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/Api/"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

      environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
   }

   attach_policy_statements = true
   policy_statements = {

     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}



module "Image_Uploader" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "Image_Uploader"
  handler       = "api.handler"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 60
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/ImageUploader/"

  environment_variables = {
    BUCKET_NAME = "${module.s3_bucket.s3_bucket_id}"
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
  }

      provisioned_concurrent_executions = 2000
  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"]
   number_of_policies = 4

   attach_policy_statements = true
   policy_statements = {
     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "Image_Uploader_public" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "Image_Uploader_Public"
  handler       = "index.handler"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/s3Upload/"
      provisioned_concurrent_executions = 2000
  environment_variables = {
    BUCKET_NAME = "${module.s3_bucket_public.s3_bucket_id}"
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
  }

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/AmazonS3FullAccess"]
   number_of_policies = 3

   attach_policy_statements = true
   policy_statements = {
     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "Create_Revenue_Table" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "Create_Revenue_Table"
  handler       = "api.revenue_codes"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 900
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/EventBridgeApi/"

  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

  environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
  }

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

   attach_policy_statements = true
   policy_statements = {
     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}



module "Get_Revenue_Item" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]


  function_name = "Get_Revenue_Item"
  handler       = "api.get_item"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 60
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024

  source_path = "${path.module}/src/EventBridgeApi/"

     provisioned_concurrent_executions = 2000
  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
   number_of_policies = 2

  environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region1
  }

   attach_policy_statements = true
   policy_statements = {
     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}


module "Create_Revenue_Item" {
  source = "terraform-aws-modules/lambda/aws"
  layers = [ aws_lambda_layer_version.lambda_layer.arn, "arn:aws:lambda:${var.region1}:580247275435:layer:LambdaInsightsExtension:21" ]

  event_source_mapping = {
    sqs = {
      function_response_types = ["ReportBatchItemFailures"]
      event_source_arn = "${aws_sqs_queue.queue.arn}"
    }
  }

  allowed_triggers = {
    sqs = {
      principal  = "sqs.amazonaws.com"
      source_arn = "${aws_sqs_queue.queue.arn}"
    }
  }

  provisioned_concurrent_executions = 2000
  function_name = "Create_Revenue_Item"
  handler       = "api.create_item"
  runtime       = "python3.8"
  architectures = ["x86_64"]
  timeout       = 60
  tracing_mode  = "Active"
  publish       = true
  store_on_s3   = false
  memory_size   = 1024


  source_path = "${path.module}/src/EventBridgeApi/"

  environment_variables = {
    SECRET_NAME = "database-terraform_secret-${random_pet.this.id}"
    REGION      = var.region2
  }


  vpc_subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [module.LambdaSecurityGroup.security_group_id]

   attach_policies    = true
   policies           = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", 
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
    ]
   number_of_policies = 3

   attach_policy_statements = true
   policy_statements = {
     secrets_manager = {
      effect = "Allow"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["*"]
     }
   }
}