// Copyright 2022 Amazon.com and its affiliates; all rights reserved.
// This file is Amazon Web Services Content and may not be duplicated or distributed without permission.

export const REMITTANCE_ENDPOINTS = {
    ApiKey: '',         // NOTE: Replace with your API Gateway key value
    Endpoint: 'https://transactionsapi.devopslord.com',     // NOTE: Replace with the URL of your API service endpoint
    Resources : ['get-lambda-payments', 'create-lambda-payment', 'update-lambda-payment', 'delete-lambda-payment', 'execute-runbook']
};
