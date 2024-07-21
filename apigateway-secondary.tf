resource "aws_api_gateway_rest_api" "my_api_sec" {
  name = "t360-rest-api"
  description = "rest api"
    provider = aws.region2

  endpoint_configuration {
    types = ["PRIVATE"]
    vpc_endpoint_ids = [module.endpoints_secondary.endpoints["api_gateway"].id]
  }
}

resource "aws_api_gateway_rest_api_policy" "this_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  policy      = data.aws_iam_policy_document.apigateway_access_secondary.json
  provider = aws.region2
}

resource "aws_api_gateway_vpc_link" "this_sec" {
  name        = "t360-vpc-link"
  target_arns = [module.nlb_sec.arn]

  provider = aws.region2
}

resource "aws_api_gateway_deployment" "this_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
    provider = aws.region2

  triggers = {
    redeployment = sha1(jsonencode([
      # aws_api_gateway_authorizer.demo_sec,
      # aws_api_gateway_authorizer.demo_sec,
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec_options,
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_sec_options,

        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec_options,
        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_sec_options,

        aws_api_gateway_method.ApiGatewayMethodGetpayments_sec,
        aws_api_gateway_method.ApiGatewayMethodGetpayments_sec_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments_sec_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments_sec,


        aws_api_gateway_method.ResourceCreatepayment_sec,
        aws_api_gateway_method.ResourceCreatepayment_sec_options,
        aws_api_gateway_integration.ResourceCreatepayment_sec,
        aws_api_gateway_integration.ResourceCreatepayment_sec_options,


        aws_api_gateway_method.ResourceUpdatepayment_sec,
        aws_api_gateway_method.ResourceUpdatepayment_sec_options,
        aws_api_gateway_integration.ResourceUpdatepayment_sec,
        aws_api_gateway_integration.ResourceUpdatepayment_sec_options,

        aws_api_gateway_method.ResourceDeletepayment_sec,
        aws_api_gateway_method.ResourceDeletepayment_sec_options,
        aws_api_gateway_integration.ResourceDeletepayment_sec,
        aws_api_gateway_integration.ResourceDeletepayment_sec_options,

        aws_api_gateway_method.ResourceClearpayments_sec,
        aws_api_gateway_method.ResourceClearpayments_sec_options,
        aws_api_gateway_integration.ResourceClearpayments_sec,
        aws_api_gateway_integration.ResourceClearpayments_sec_options,

      aws_api_gateway_resource.demo_sec,
      aws_api_gateway_integration.demo_sec,
      # aws_api_gateway_rest_api_policy.this_sec,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_sec,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_sec_options,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_sec,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_sec_options,

      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec,
      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_sec,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_sec_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_sec,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_sec_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_sec,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_sec_options,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [ 
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec_options,
        aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_sec_options,

        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec_options,
        aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_sec,
        aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_sec_options,

        aws_api_gateway_method.ApiGatewayMethodGetpayments_sec,
        aws_api_gateway_method.ApiGatewayMethodGetpayments_sec_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments_sec_options,
        aws_api_gateway_integration.ApiGatewayMethodGetpayments_sec,


        aws_api_gateway_method.ResourceCreatepayment_sec,
        aws_api_gateway_method.ResourceCreatepayment_sec_options,
        aws_api_gateway_integration.ResourceCreatepayment_sec,
        aws_api_gateway_integration.ResourceCreatepayment_sec_options,


        aws_api_gateway_method.ResourceUpdatepayment_sec,
        aws_api_gateway_method.ResourceUpdatepayment_sec_options,
        aws_api_gateway_integration.ResourceUpdatepayment_sec,
        aws_api_gateway_integration.ResourceUpdatepayment_sec_options,

        aws_api_gateway_method.ResourceDeletepayment_sec,
        aws_api_gateway_method.ResourceDeletepayment_sec_options,
        aws_api_gateway_integration.ResourceDeletepayment_sec,
        aws_api_gateway_integration.ResourceDeletepayment_sec_options,

        aws_api_gateway_method.ResourceClearpayments_sec,
        aws_api_gateway_method.ResourceClearpayments_sec_options,
        aws_api_gateway_integration.ResourceClearpayments_sec,
        aws_api_gateway_integration.ResourceClearpayments_sec_options,

      aws_api_gateway_resource.demo_sec,
      aws_api_gateway_integration.demo_sec,
      #aws_api_gateway_rest_api_policy.this_sec,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_sec,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_sec_options,

      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec,
      aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_sec,
      aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_sec_options,

      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec,
      aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_sec,
      aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_sec_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_sec,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_sec_options,

      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec,
      aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec_options,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_sec,
      aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_sec_options,


    ]
}


resource "aws_api_gateway_stage" "this_sec" {
  deployment_id = aws_api_gateway_deployment.this_sec.id
  rest_api_id   = aws_api_gateway_rest_api.my_api_sec.id
  stage_name    = "dev"
    provider = aws.region2
}


# resource "aws_api_gateway_authorizer" "demo_sec" {
#   name                   = "CognitoAuthorizer"
#   rest_api_id            = aws_api_gateway_rest_api.my_api_sec.id
#   identity_source        = "method.request.header.authorization"
#   type                   = "COGNITO_USER_POOLS"
#   provider_arns          = [ "${aws_cognito_user_pool.user_pool.arn}" ]  
#     provider = aws.region2
# }

resource "aws_api_gateway_domain_name" "this_sec" {
  regional_certificate_arn = module.acm_secondary.acm_certificate_arn
  domain_name     = "${var.domain_name}"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
    provider = aws.region2
}


resource "aws_api_gateway_base_path_mapping" "this_sec" {
  api_id      = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  domain_name = aws_api_gateway_domain_name.this_sec.domain_name

  depends_on = [ aws_api_gateway_deployment.this_sec ]
    provider = aws.region2
}


##########################################
# Get region method
##########################################

resource "aws_api_gateway_resource" "demo_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "get-region"
    provider = aws.region2
}

resource "aws_api_gateway_method" "demo_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.demo_sec.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
    provider = aws.region2
}

resource "aws_api_gateway_integration" "demo_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.demo_sec.id
  http_method = aws_api_gateway_method.demo_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.lambda_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
    provider = aws.region2
}

resource "aws_api_gateway_method_response" "demo_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.demo_sec.id
  http_method = aws_api_gateway_method.demo_sec.http_method
  status_code = "200"
    provider = aws.region2

  //cors section
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }

}

resource "aws_api_gateway_integration_response" "demo_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.demo_sec.id
  http_method = aws_api_gateway_method.demo_sec.http_method
  status_code = aws_api_gateway_method_response.demo_sec.status_code
    provider = aws.region2


  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
}

  depends_on = [
    aws_api_gateway_method.demo_sec,
    aws_api_gateway_integration.demo_sec
  ]
}


############################################
# create payment table
############################################

resource "aws_api_gateway_resource" "ApiGatewayMethodCreatepaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "create-payments-lambda-db-table"
    provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreatepaymentTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
    provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreatepaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
    provider = aws.region2
}

resource "aws_api_gateway_method_settings" "this_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  method_path = "*/*"
    provider = aws.region2

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreatepaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
    provider = aws.region2
  uri = "${module.CreatepaymentTableLambdaFunction_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreatepaymentTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
    provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreatepaymentTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec_options.http_method
  status_code = "200"
    provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreatepaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec.http_method
  status_code = "200"
    provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "get-cluster-info_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreatepaymentTable_sec_options.status_code
    provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec,
    aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_sec_options
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

resource "aws_api_gateway_integration_response" "get-cluster-info_sec_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreatepaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreatepaymentTable_sec.status_code
    provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreatepaymentTable_sec,
    aws_api_gateway_integration.ApiGatewayMethodCreatepaymentTable_sec
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

resource "aws_api_gateway_resource" "ApiGatewayMethodDroppaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "drop-payment-table"
    provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodDroppaymentTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
      provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodDroppaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable_sec.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
      provider = aws.region2
}

resource "aws_api_gateway_method_settings" "ApiGatewayMethodDroppaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  method_path = "*/*"
      provider = aws.region2

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodDroppaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.DroppaymentTableLambdaFunction_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
      provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodDroppaymentTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
      provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodDroppaymentTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec_options.http_method
  status_code = "200"
      provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodDroppaymentTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodDroppaymentTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodDroppaymentTable_sec_options.status_code
      provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodDroppaymentTable_sec,
    aws_api_gateway_integration.ApiGatewayMethodDroppaymentTable_sec_options
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

resource "aws_api_gateway_resource" "ApiGatewayMethodGetpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "get-lambda-payments"
      provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetpayments_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
  api_key_required = false
      provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments_sec.id
  http_method = "GET"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
      provider = aws.region2
}

resource "aws_api_gateway_method_settings" "ApiGatewayMethodGetpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  method_path = "*/*"
      provider = aws.region2

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.GetpaymentsLambdaFunction_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
      provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetpayments_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
      provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodGetpayments_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments_sec_options.http_method
  status_code = "200"
      provider = aws.region2
  

  response_models = {
    "application/json" = "Empty"
  }


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false,
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodGetpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetpayments_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetpayments_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodGetpayments_sec_options.status_code
      provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodGetpayments_sec,
    aws_api_gateway_integration.ApiGatewayMethodGetpayments_sec_options
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

resource "aws_api_gateway_resource" "ResourceCreatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "create-lambda-payment"
      provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceCreatepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
      provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceCreatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment_sec.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
      provider = aws.region2
}

resource "aws_api_gateway_method_settings" "ResourceCreatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  method_path = "*/*"
      provider = aws.region2

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceCreatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceCreatepayment_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.CreatepaymentLambdaFunction_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
      provider = aws.region2
}

resource "aws_api_gateway_integration" "ResourceCreatepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceCreatepayment_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
      provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceCreatepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceCreatepayment_sec_options.http_method
  status_code = "200"
      provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceCreatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceCreatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceCreatepayment_sec_options.http_method
  status_code = aws_api_gateway_method_response.ResourceCreatepayment_sec_options.status_code
      provider = aws.region2
  

  depends_on = [
    aws_api_gateway_method.ResourceCreatepayment_sec,
    aws_api_gateway_integration.ResourceCreatepayment_sec_options
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

resource "aws_api_gateway_resource" "ResourceUpdatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "update-lambda-payment"
      provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceUpdatepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
      provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceUpdatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment_sec.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
      provider = aws.region2
}

resource "aws_api_gateway_method_settings" "ResourceUpdatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  method_path = "*/*"
      provider = aws.region2
  

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceUpdatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.UpdatepaymentLambdaFunction_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ResourceUpdatepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceUpdatepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceUpdatepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceUpdatepayment_sec.id
  http_method = aws_api_gateway_method.ResourceUpdatepayment_sec_options.http_method
  status_code = aws_api_gateway_method_response.ResourceUpdatepayment_sec_options.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ResourceUpdatepayment_sec,
    aws_api_gateway_integration.ResourceUpdatepayment_sec_options
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

resource "aws_api_gateway_resource" "ResourceDeletepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "delete-lambda-payment"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceDeletepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceDeletepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment_sec.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
        provider = aws.region2
}

resource "aws_api_gateway_method_settings" "ResourceDeletepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  method_path = "*/*"
        provider = aws.region2

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceDeletepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment_sec.id
  http_method = aws_api_gateway_method.ResourceDeletepayment_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.DeletepaymentLambdaFunction_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ResourceDeletepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment_sec.id
  http_method = aws_api_gateway_method.ResourceDeletepayment_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceDeletepayment_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment_sec.id
  http_method = aws_api_gateway_method.ResourceDeletepayment_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceDeletepayment_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceDeletepayment_sec.id
  http_method = aws_api_gateway_method.ResourceDeletepayment_sec_options.http_method
  status_code = aws_api_gateway_method_response.ResourceDeletepayment_sec_options.status_code
        provider = aws.region2
  

  depends_on = [
    aws_api_gateway_method.ResourceDeletepayment_sec,
    aws_api_gateway_integration.ResourceDeletepayment_sec_options
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

resource "aws_api_gateway_resource" "ResourceClearpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "clear-payments"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceClearpayments_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ResourceClearpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments_sec.id
  http_method = "POST"
  authorization = "NONE"
  #authorizer_id = aws_api_gateway_authorizer.demo_sec.id
        provider = aws.region2
}

resource "aws_api_gateway_method_settings" "ResourceClearpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  stage_name  = aws_api_gateway_stage.this_sec.stage_name
  method_path = "*/*"
        provider = aws.region2

  settings {
    metrics_enabled = false
    logging_level   = "OFF"
  }
}

resource "aws_api_gateway_integration" "ResourceClearpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments_sec.id
  http_method = aws_api_gateway_method.ResourceClearpayments_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.ClearpaymentsLambdaFunction_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ResourceClearpayments_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments_sec.id
  http_method = aws_api_gateway_method.ResourceClearpayments_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ResourceClearpayments_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments_sec.id
  http_method = aws_api_gateway_method.ResourceClearpayments_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ResourceClearpayments_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ResourceClearpayments_sec.id
  http_method = aws_api_gateway_method.ResourceClearpayments_sec_options.http_method
  status_code = aws_api_gateway_method_response.ResourceClearpayments_sec_options.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ResourceClearpayments_sec,
    aws_api_gateway_integration.ResourceClearpayments_sec_options
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

resource "aws_api_gateway_resource" "ApiGatewayMethodCreateRevenueTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "create-revenue-sqs-table"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = "POST"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Create_Revenue_Table_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueTable_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueTable_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueTable_sec_options.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_sec_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueTable_sec_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueTable_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueTable_sec.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueTable_sec,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueTable_sec
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

resource "aws_api_gateway_resource" "ApiGatewayMethodCreateRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "create-revenue-sqs-item"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueItem_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodCreateRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = "POST"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri  = "arn:aws:apigateway:${var.region1}:events:action/PutEvents" 
  passthrough_behavior = "WHEN_NO_TEMPLATES"
        provider = aws.region2
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
                "EventBusName": "${module.eventbridge_secondary.eventbridge_bus_name}", 
                "Source": "api.gateway.ca.create" 
              }
            ]
          }
        EOT
  }
}

resource "aws_api_gateway_integration" "ApiGatewayMethodCreateRevenueItem_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueItem_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodCreateRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueItem_sec_options.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_sec_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodCreateRevenueItem_sec_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodCreateRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodCreateRevenueItem_sec.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodCreateRevenueItem_sec,
    aws_api_gateway_integration.ApiGatewayMethodCreateRevenueItem_sec
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

resource "aws_api_gateway_resource" "ApiGatewayMethodGetRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "get-revenue-sqs-item"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetRevenueItem_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodGetRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = "GET"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Get_Revenue_Item_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodGetRevenueItem_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodGetRevenueItem_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodGetRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodGetRevenueItem_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodGetRevenueItem_sec_options.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec,
    aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_sec_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodGetRevenueItem_sec_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodGetRevenueItem_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodGetRevenueItem_sec.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodGetRevenueItem_sec,
    aws_api_gateway_integration.ApiGatewayMethodGetRevenueItem_sec
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

resource "aws_api_gateway_resource" "ApiGatewayMethodUploadImagePublic_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "upload-image-public"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePublic_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePublic_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = "POST"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePublic_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Image_Uploader_public_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePublic_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePublic_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePublic_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePublic_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePublic_sec_options.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_sec_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePublic_sec_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePublic_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePublic_sec.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePublic_sec,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePublic_sec
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

resource "aws_api_gateway_resource" "ApiGatewayMethodUploadImagePrivate_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  parent_id = aws_api_gateway_rest_api.my_api_sec.root_resource_id
  path_part = "upload-image-private"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePrivate_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = "OPTIONS"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_method" "ApiGatewayMethodUploadImagePrivate_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = "POST"
  authorization = "NONE"
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePrivate_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${module.Image_Uploader_secondary.lambda_function_invoke_arn}"  
  credentials = module.apigateway_put_events_to_lambda_us_east_1.iam_role_arn
        provider = aws.region2
}

resource "aws_api_gateway_integration" "ApiGatewayMethodUploadImagePrivate_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec_options.http_method
  type = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
        provider = aws.region2

  request_templates = {
    "application/json" = jsonencode({statusCode = 200})
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePrivate_sec_options" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec_options.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ApiGatewayMethodUploadImagePrivate_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec.http_method
  status_code = "200"
        provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePrivate_sec" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec_options.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePrivate_sec_options.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_sec_options
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

}

resource "aws_api_gateway_integration_response" "ApiGatewayMethodUploadImagePrivate_sec_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ApiGatewayMethodUploadImagePrivate_sec.id
  http_method = aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec.http_method
  status_code = aws_api_gateway_method_response.ApiGatewayMethodUploadImagePrivate_sec.status_code
        provider = aws.region2

  depends_on = [
    aws_api_gateway_method.ApiGatewayMethodUploadImagePrivate_sec,
    aws_api_gateway_integration.ApiGatewayMethodUploadImagePrivate_sec
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


resource "aws_api_gateway_resource" "ecs_api_secondary" {
  rest_api_id = "${aws_api_gateway_rest_api.my_api_sec.id}"
  parent_id   = "${aws_api_gateway_rest_api.my_api_sec.root_resource_id}"
  path_part   = "ecs-api"
  provider = aws.region2
}

resource "aws_api_gateway_method" "ecs_api_secondary" {
  rest_api_id   = "${aws_api_gateway_rest_api.my_api_sec.id}"
  resource_id   = "${aws_api_gateway_resource.ecs_api_secondary.id}"
  http_method   = "POST"
  authorization = "NONE"
  provider = aws.region2

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method" "ecs_api_secondary_get" {
  rest_api_id   = "${aws_api_gateway_rest_api.my_api_sec.id}"
  resource_id   = "${aws_api_gateway_resource.ecs_api_secondary.id}"
  http_method   = "GET"
  authorization = "NONE"
  provider = aws.region2

  request_parameters = {
    "method.request.path.proxy" = true
  }
}


resource "aws_api_gateway_integration" "ecs_api_secondary" {
  rest_api_id = "${aws_api_gateway_rest_api.my_api_sec.id}"
  resource_id = "${aws_api_gateway_resource.ecs_api_secondary.id}"
  http_method = "${aws_api_gateway_method.ecs_api_secondary.http_method}"
  provider = aws.region2


  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  type                    = "HTTP"
  uri                     = "http://${module.nlb_sec.dns_name}/blogs/"
  integration_http_method = aws_api_gateway_method.ecs_api_secondary.http_method

  connection_type = "VPC_LINK"
  connection_id   = "${aws_api_gateway_vpc_link.this_sec.id}"
}

resource "aws_api_gateway_integration" "ecs_api_secondary_get" {
  rest_api_id = "${aws_api_gateway_rest_api.my_api_sec.id}"
  resource_id = "${aws_api_gateway_resource.ecs_api_secondary.id}"
  http_method = "${aws_api_gateway_method.ecs_api_secondary_get.http_method}"
  provider = aws.region2


  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  type                    = "HTTP"
  uri                     = "http://${module.nlb_sec.dns_name}/blogs/"
  integration_http_method = aws_api_gateway_method.ecs_api_secondary_get.http_method

  connection_type = "VPC_LINK"
  connection_id   = "${aws_api_gateway_vpc_link.this_sec.id}"
}

resource "aws_api_gateway_method_response" "ecs_api_secondary" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ecs_api_secondary.id
  http_method = aws_api_gateway_method.ecs_api_secondary.http_method
  status_code = "200"
  provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}

resource "aws_api_gateway_method_response" "ecs_api_secondary_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ecs_api_secondary.id
  http_method = aws_api_gateway_method.ecs_api_secondary_get.http_method
  status_code = "200"
  provider = aws.region2


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin" = false
  }
}


resource "aws_api_gateway_integration_response" "ecs_api_secondary" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ecs_api_secondary.id
  http_method = aws_api_gateway_method.ecs_api_secondary.http_method
  status_code = aws_api_gateway_method_response.ecs_api_secondary.status_code
  provider = aws.region2
  

  depends_on = [
    aws_api_gateway_method.ecs_api_secondary,
    aws_api_gateway_integration.ecs_api_secondary
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}


resource "aws_api_gateway_integration_response" "ecs_api_secondary_get" {
  rest_api_id = aws_api_gateway_rest_api.my_api_sec.id
  resource_id = aws_api_gateway_resource.ecs_api_secondary.id
  http_method = aws_api_gateway_method.ecs_api_secondary_get.http_method
  status_code = aws_api_gateway_method_response.ecs_api_secondary_get.status_code
  provider = aws.region2
  

  depends_on = [
    aws_api_gateway_method.ecs_api_secondary_get,
    aws_api_gateway_integration.ecs_api_secondary_get
  ]

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'",
  }
}