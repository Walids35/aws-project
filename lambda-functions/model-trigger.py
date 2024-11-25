import boto3
import json
import numpy as np

# Initialize SageMaker Runtime client
runtime_client = boto3.client('sagemaker-runtime')

# Replace with your SageMaker endpoint name
SAGEMAKER_ENDPOINT_NAME = '' #fill with your endpoint name

def lambda_handler(event, context):
    try:
        # Extract the body from the event, API Gateway sends it in the 'body' field
        if event.get('isBase64Encoded', False):
            # If the body is base64-encoded (common with binary payloads)
            body = json.loads(base64.b64decode(event['body']).decode('utf-8'))
        else:
            # If the body is directly in JSON format
            body = json.loads(event['body'])

        # Extract and preprocess data from the body
        input_data = body.get('data', [])
        if not input_data:
            return {
                'statusCode': 400,
                'body': json.dumps('No data provided in the request.')
            }

        # Ensure input_data is reshaped to (1, 4, 1, 1)
        reshaped_input = np.array(input_data).reshape(1, 4, 1, 1)  # Shape (1, 4, 1, 1)
        
        # Prepare the input data as a list of lists for SageMaker endpoint
        input_data_reshaped = reshaped_input.tolist()  # Convert to list for payload

        # Create the payload in the required format
        payload = json.dumps({'instances': input_data_reshaped})

        # Invoke the SageMaker endpoint
        response = runtime_client.invoke_endpoint(
            EndpointName=SAGEMAKER_ENDPOINT_NAME,
            Body=payload,
            ContentType='application/json'
        )

        # Parse response
        result = json.loads(response['Body'].read().decode())
        
        # Return prediction results
        return {
            'statusCode': 200,
            'body': json.dumps({'predictions': result})
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error: {str(e)}")
        }
