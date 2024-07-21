resource "aws_api_gateway_rest_api" "my_api" {
  name = "t360-rest-api"
  description = "rest api"

  endpoint_configuration {
    types = ["PRIVATE"]
    vpc_endpoint_ids = [module.endpoints.endpoints["api_gateway"].id]
  }
}

resource "aws_api_gateway_rest_api_policy" "this" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  policy      = data.aws_iam_policy_document.apigateway_access.json
}

#########################
# load balancer 
#########################

resource "aws_api_gateway_vpc_link" "this" {
  name        = "t360-vpc-link"
  target_arns = [module.nlb.arn]
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      # aws_api_gateway_authorizer.demo,
      # aws_api_gateway_authorizer.demo,
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_options,
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_options,

        aws_api_gateway_method.ecs_api,
        aws_api_gateway_integration.ecs_api,

        aws_api_gateway_method.ecs_api_get,
        aws_api_gateway_integration.ecs_api_get,

        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_options,
        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_options,

        aws_api_gateway_method.ApiGatewayMethodGetpayments,
        aws_api_gateway_method.ApiGatewayMethodGetpayments_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments,


        aws_api_gateway_method.ResourceCreatepayment,
        aws_api_gateway_method.ResourceCreatepayment_options,
        aws_api_gateway_integration.ResourceCreatepayment,
        aws_api_gateway_integration.ResourceCreatepayment_options,


        aws_api_gateway_method.ResourceUpdatepayment,
        aws_api_gateway_method.ResourceUpdatepayment_options,
        aws_api_gateway_integration.ResourceUpdatepayment,
        aws_api_gateway_integration.ResourceUpdatepayment_options,

        aws_api_gateway_method.ResourceDeletepayment,
        aws_api_gateway_method.ResourceDeletepayment_options,
        aws_api_gateway_integration.ResourceDeletepayment,
        aws_api_gateway_integration.ResourceDeletepayment_options,

        aws_api_gateway_method.ResourceClearpayments,
        aws_api_gateway_method.ResourceClearpayments_options,
        aws_api_gateway_integration.ResourceClearpayments,
        aws_api_gateway_integration.ResourceClearpayments_options,

      aws_api_gateway_resource.demo,
      aws_api_gateway_integration.demo,
      # aws_api_gateway_rest_api_policy.this,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_options,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_options,

      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem,
      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_options,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_options,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [ 
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_options,
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_options,

        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_options,
        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_options,

        aws_api_gateway_method.ApiGatewayMethodGetpayments,
        aws_api_gateway_method.ApiGatewayMethodGetpayments_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments,


        aws_api_gateway_method.ResourceCreatepayment,
        aws_api_gateway_method.ResourceCreatepayment_options,
        aws_api_gateway_integration.ResourceCreatepayment,
        aws_api_gateway_integration.ResourceCreatepayment_options,


        aws_api_gateway_method.ResourceUpdatepayment,
        aws_api_gateway_method.ResourceUpdatepayment_options,
        aws_api_gateway_integration.ResourceUpdatepayment,
        aws_api_gateway_integration.ResourceUpdatepayment_options,

        aws_api_gateway_method.ResourceDeletepayment,
        aws_api_gateway_method.ResourceDeletepayment_options,
        aws_api_gateway_integration.ResourceDeletepayment,
        aws_api_gateway_integration.ResourceDeletepayment_options,

        aws_api_gateway_method.ResourceClearpayments,
        aws_api_gateway_method.ResourceClearpayments_options,
        aws_api_gateway_integration.ResourceClearpayments,
        aws_api_gateway_integration.ResourceClearpayments_options,

      aws_api_gateway_resource.demo,
      aws_api_gateway_integration.demo,
      # aws_api_gateway_rest_api_policy.this,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_options,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_options,

      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem,
      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_options,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_options,


    ]
}


resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  stage_name    = "dev"
}


# resource "aws_api_gateway_authorizer" "demo" {
#   name                   = "CognitoAuthorizer"
#   rest_api_id            = aws_api_gateway_rest_api.my_api.id
#   identity_source        = "method.request.header.authorization"
#   type                   = "COGNITO_USER_POOLS"
#   provider_arns          = [ "${aws_cognito_user_pool.user_pool.arn}" ]  
# }

resource "aws_api_gateway_domain_name" "this" {
  regional_certificate_arn = module.acm.acm_certificate_arn
  domain_name     = "${var.domain_name}"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  
}


resource "aws_api_gateway_base_path_mapping" "this" {
  api_id      = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  domain_name = aws_api_gateway_domain_name.this.domain_name

  depends_on = [ aws_api_gateway_deployment.this ]
}


##########################################
# Get region method
##########################################

resource "aws_api_gateway_resource" "demo" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "get-region"
}

resource "aws_api_gateway_method" "demo" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.demo.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_integration" "demo" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.demo.id
  http_method = aws_api_gateway_method.demo.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.lambda_primary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_method_response" "demo" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.demo.id
  http_method = aws_api_gateway_method.demo.http_method
  status_code = "200"

  //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }

}

resource "aws_api_gateway_integration_response" "demo" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.demo.id
  http_method = aws_api_gateway_method.demo.http_method
  status_code = aws_api_gateway_method_response.demo.status_code


  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
}

  depends_on = [
    aws_api_gateway_method.demo,
    aws_api_gateway_integration.demo
  ]
}


############################################
# create payment 
############################################

resource "aws_api_gateway_resource" "ApiGatewayMethodCreatepaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "create-payments-lambda-db-table"
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreatepaymentTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreatepaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = "GET"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreatepaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.CreatepaymentTableLambdaFunction.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreatepaymentTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreatepaymentTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreatepaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "get-cluster-info" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreatepaymentTable_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable,
    aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = null
  }
}

resource "aws_api_gateway_integration_response" "get-cluster-info_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreatepaymentTable.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable,
    aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }

  response_templates = {
    "application/json" = null
  }
}



############################################
# Drop payment 
############################################

resource "aws_api_gateway_resource" "ApiGatewayMethodDroppaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "drop-payment-table"
}

resource "aws_api_gateway_method" "ApiGatewayMethodDroppaymentTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ApiGatewayMethodDroppaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_method_settings" "ApiGatewayMethodDroppaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodDroppaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.DroppaymentTableLambdaFunction.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodDroppaymentTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodDroppaymentTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodDroppaymentTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodDroppaymentTable_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodDroppaymentTable,
    aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = null
  }
}


############################################
# Get payment 
############################################

resource "aws_api_gateway_resource" "ApiGatewayMethodGetpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "get-lambda-payments"
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetpayments_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments.id
  http_method = "OPTIONS"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments.id
  http_method = "GET"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_method_settings" "ApiGatewayMethodGetpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.GetpaymentsLambdaFunction.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetpayments_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodGetpayments_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments_options.http_method
  status_code = "200"
  

  response_models = {
    "application/json" = "Empty"
  }


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false,
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodGetpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodGetpayments_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodGetpayments,
    aws_api_gateway_integration.ApiGatewayMethodGetpayments_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = null
  }
}





############################################
# Create payment 
############################################

resource "aws_api_gateway_resource" "ResourceCreatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "create-lambda-payment"
}

resource "aws_api_gateway_method" "ResourceCreatepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ResourceCreatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_method_settings" "ResourceCreatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceCreatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment.id
  http_method = aws_api_gateway_method.ResourceCreatepayment.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.CreatepaymentLambdaFunction.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ResourceCreatepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment.id
  http_method = aws_api_gateway_method.ResourceCreatepayment_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceCreatepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment.id
  http_method = aws_api_gateway_method.ResourceCreatepayment_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceCreatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment.id
  http_method = aws_api_gateway_method.ResourceCreatepayment_options.http_method
  status_code = aws_api_gateway_method_response.ResourceCreatepayment_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ResourceCreatepayment,
    aws_api_gateway_integration.ResourceCreatepayment_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = null
  }
}




############################################
# Update payment 
############################################

resource "aws_api_gateway_resource" "ResourceUpdatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "update-lambda-payment"
}

resource "aws_api_gateway_method" "ResourceUpdatepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ResourceUpdatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_method_settings" "ResourceUpdatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceUpdatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.UpdatepaymentLambdaFunction.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ResourceUpdatepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceUpdatepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceUpdatepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment_options.http_method
  status_code = aws_api_gateway_method_response.ResourceUpdatepayment_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ResourceUpdatepayment,
    aws_api_gateway_integration.ResourceUpdatepayment_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = null
  }
}



############################################
# Delete payment 
############################################

resource "aws_api_gateway_resource" "ResourceDeletepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "delete-lambda-payment"
}

resource "aws_api_gateway_method" "ResourceDeletepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ResourceDeletepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_method_settings" "ResourceDeletepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceDeletepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment.id
  http_method = aws_api_gateway_method.ResourceDeletepayment.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.DeletepaymentLambdaFunction.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ResourceDeletepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment.id
  http_method = aws_api_gateway_method.ResourceDeletepayment_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceDeletepayment_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment.id
  http_method = aws_api_gateway_method.ResourceDeletepayment_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceDeletepayment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment.id
  http_method = aws_api_gateway_method.ResourceDeletepayment_options.http_method
  status_code = aws_api_gateway_method_response.ResourceDeletepayment_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ResourceDeletepayment,
    aws_api_gateway_integration.ResourceDeletepayment_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = null
  }
}


############################################
# Clear payment 
############################################

resource "aws_api_gateway_resource" "ResourceClearpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "clear-payments"
}

resource "aws_api_gateway_method" "ResourceClearpayments_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ResourceClearpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_method_settings" "ResourceClearpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceClearpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments.id
  http_method = aws_api_gateway_method.ResourceClearpayments.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.ClearpaymentsLambdaFunction.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ResourceClearpayments_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments.id
  http_method = aws_api_gateway_method.ResourceClearpayments_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceClearpayments_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments.id
  http_method = aws_api_gateway_method.ResourceClearpayments_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceClearpayments" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments.id
  http_method = aws_api_gateway_method.ResourceClearpayments_options.http_method
  status_code = aws_api_gateway_method_response.ResourceClearpayments_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ResourceClearpayments,
    aws_api_gateway_integration.ResourceClearpayments_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = null
  }
}


##########################################
# create revenue table method
##########################################

resource "aws_api_gateway_resource" "ApiGatewayMethodCreateRevenueTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "create-lambda-sqs-db-table"
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Create_Revenue_Table.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueTable_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueTable" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueTable_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueTable_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueTable.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}




##########################################
# create revenue item method
##########################################

resource "aws_api_gateway_resource" "ApiGatewayMethodCreateRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "create-revenue-sqs-item"
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueItem_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri  = "arn:aws:apigateway:${var.region1}:events:action/PutEvents" 
  passthrough_behavior = "WHEN_NO_TEMPLATES"
  credentials = module.apigateway_put_events_to_eventbridge_role.iam_role_arn


  request_templates = {
        "application/json" = <<-EOT
            #set($context.requestOverride.header.X-Amz-Target = "AWSEvents.PutEvents")
            #set($context.requestOverride.header.Content-Type = "application/x-amz-json-1.1")            
            #set($inputRoot = $input.json('$')) 
          {
            "Entries": [
              {
                "Detail": "$util.escapeJavaScript($inputRoot).replaceAll("\\'","'")",
                "DetailType": "Order Create", 
                "EventBusName": "${module.eventbridge.eventbridge_bus_name}", 
                "Source": "api.gateway.ca.create" 
              }
            ]
          }
        EOT
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueItem_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueItem_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueItem_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueItem_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueItem.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}


##########################################
# get revenue item method
##########################################

resource "aws_api_gateway_resource" "ApiGatewayMethodGetRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "get-revenue-sqs-item"
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetRevenueItem_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Get_Revenue_Item.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetRevenueItem_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodGetRevenueItem_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodGetRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodGetRevenueItem" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodGetRevenueItem_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodGetRevenueItem,
    aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodGetRevenueItem_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodGetRevenueItem.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodGetRevenueItem,
    aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}


##########################################
# Upload public Image to s3
##########################################

resource "aws_api_gateway_resource" "ApiGatewayMethodUploadImagePublic" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "upload-image-public"
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePublic_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePublic" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePublic" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Image_Uploader_public.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePublic_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePublic_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePublic" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePublic" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePublic_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePublic,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePublic_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePublic.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePublic,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}



##########################################
# Upload private Image to s3
##########################################

resource "aws_api_gateway_resource" "ApiGatewayMethodUploadImagePrivate" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part = "upload-image-private"
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePrivate_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePrivate" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePrivate" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Image_Uploader.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePrivate_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePrivate_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_options.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePrivate" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePrivate" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePrivate_options.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePrivate_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePrivate.status_code
  

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}



#####################################
# ECS APi route
#####################################


resource "aws_api_gateway_resource" "ecs_api" {
  rest_api_id = "${aws_api_gateway_rest_api.my_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.my_api.root_resource_id}"
  path_part   = "ecs-api"
}

resource "aws_api_gateway_method" "ecs_api" {
  rest_api_id   = "${aws_api_gateway_rest_api.my_api.id}"
  resource_id   = "${aws_api_gateway_resource.ecs_api.id}"
  http_method   = "POST"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method" "ecs_api_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.my_api.id}"
  resource_id   = "${aws_api_gateway_resource.ecs_api.id}"
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}


resource "aws_api_gateway_integration" "ecs_api" {
  rest_api_id = "${aws_api_gateway_rest_api.my_api.id}"
  resource_id = "${aws_api_gateway_resource.ecs_api.id}"
  http_method = "${aws_api_gateway_method.ecs_api.http_method}"


  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  type                    = "HTTP"
  uri                     = "http://${module.nlb.dns_name}/blogs/"
  integration_http_method = aws_api_gateway_method.ecs_api.http_method

  connection_type = "VPC_LINK"
  connection_id   = "${aws_api_gateway_vpc_link.this.id}"
}

resource "aws_api_gateway_integration" "ecs_api_get" {
  rest_api_id = "${aws_api_gateway_rest_api.my_api.id}"
  resource_id = "${aws_api_gateway_resource.ecs_api.id}"
  http_method = "${aws_api_gateway_method.ecs_api_get.http_method}"


  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  type                    = "HTTP"
  uri                     = "http://${module.nlb.dns_name}/blogs/"
  integration_http_method = aws_api_gateway_method.ecs_api_get.http_method

  connection_type = "VPC_LINK"
  connection_id   = "${aws_api_gateway_vpc_link.this.id}"
}

resource "aws_api_gateway_method_response" "ecs_api" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ecs_api.id
  http_method = aws_api_gateway_method.ecs_api.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ecs_api_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ecs_api.id
  http_method = aws_api_gateway_method.ecs_api_get.http_method
  status_code = "200"


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}


resource "aws_api_gateway_integration_response" "ecs_api" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ecs_api.id
  http_method = aws_api_gateway_method.ecs_api.http_method
  status_code = aws_api_gateway_method_response.ecs_api.status_code
  

  depends_on = [
    aws_api_gateway_method.ecs_api,
    aws_api_gateway_integration.ecs_api
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}


resource "aws_api_gateway_integration_response" "ecs_api_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.ecs_api.id
  http_method = aws_api_gateway_method.ecs_api_get.http_method
  status_code = aws_api_gateway_method_response.ecs_api_get.status_code
  

  depends_on = [
    aws_api_gateway_method.ecs_api_get,
    aws_api_gateway_integration.ecs_api_get
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}