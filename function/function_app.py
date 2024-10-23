import json
import os
import logging
import azure.functions as func
from azure.cosmos import CosmosClient, exceptions

endpoint = os.environ["COSMOS_ENDPOINT"]
account_key = os.environ["COSMOS_KEY"]
domain_name = os.environ["DOMAIN_NAME"]
client = CosmosClient(url=endpoint, credential=account_key)
database_name = "ResumeDB"
container_name = "ResumeContainer"
item_id = "1"
database = client.get_database_client(database_name)
container = database.get_container_client(container_name)

app = func.FunctionApp(http_auth_level=func.AuthLevel.FUNCTION)

@app.route(route="http_trigger")
def http_trigger(req: func.HttpRequest) -> func.HttpResponse:

    # CORS headers
    headers = {
        "Access-Control-Allow-Origin": domain_name,
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type",
        "Access-Control-Max-Age": "86400",
        "Cache-Control": "no-cache"
    }

    # Handle CORS preflight requests
    if req.method == "OPTIONS":
        return func.HttpResponse(status_code=204, headers=headers)

    try:
        if req.method == "GET":
            try:
                # Get current count
                count_item = container.read_item(item_id, item_id)

                # Return response
                return func.HttpResponse(
                    body=json.dumps({"count": count_item['count']}),
                    mimetype='application/json',
                    headers=headers,
                    status_code=200
                )
            except exceptions.CosmosResourceNotFoundError:
                # Initialize counter if it doesn't exist
                count_item = {
                    'id': item_id,
                    'count': 0
                }
                # Create in database
                container.create_item(count_item)

                # Return response
                return func.HttpResponse(
                    body=json.dumps({"count": 0}),
                    mimetype='application/json',
                    headers=headers,
                    status_code=200
                )

        elif req.method == "POST":
            try:
                # Get current count
                count_item = container.read_item(item_id, item_id)
                
                # Increment count
                count_item['count'] += 1
                
                # Update in database
                container.upsert_item(count_item)
                
                # Return response
                return func.HttpResponse(
                    body=json.dumps({"count": count_item['count']}),
                    mimetype='application/json',
                    headers=headers,
                    status_code=200
                )
            except exceptions.CosmosResourceNotFoundError:
                # Initialize counter if it doesn't exist
                count_item = {
                    'id': item_id,
                    'count': 1
                }
                # Create in database
                container.create_item(count_item)

                # Return response
                return func.HttpResponse(
                    body=json.dumps({"count": 1}),
                    mimetype='application/json',
                    headers=headers,
                    status_code=200
                )

    except Exception as e:
        logging.error(f"Error processing request: {str(e)}")

        # Return response
        return func.HttpResponse(
            body=json.dumps({"error": "Internal server error"}),
            mimetype='application/json',
            headers=headers,
            status_code=500
        )
