#!/bin/bash

# Get the Vercel API endpoints.
GET_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v6/deployments"
DELETE_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v13/deployments"

# Create a list of deployments.
deployments=$(curl -s -X GET "$GET_DEPLOYMENTS_ENDPOINT/?projectId=$VERCEL_PROJECT_ID&teamId=$VERCEL_ORG_ID&limit=1000" -H "Authorization: Bearer $VERCEL_TOKEN ")
echo $deployments
echo "================================================================="
filtered_deployments=$(curl -H "Authorization: Bearer $VERCEL_TOKEN" -s -X GET "$GET_DEPLOYMENTS_ENDPOINT/?projectId=$VERCEL_PROJECT_ID&teamId=$VERCEL_ORG_ID&limit=1000" 
| jq -r --arg branch "$BRANCH" '.deployments[] | select(.meta.githubCommitRef == $branch) | .uid')

uid="${filtered_deployments//\"/}"
echo "Filtered deployments ${uid}"
echo "action $ACTIONS to destroy"
echo "================================================================="


for id in $uid; do
    echo "================================================================="
    echo "Deleting deployment $id ..."        
    delete_url="${DELETE_DEPLOYMENTS_ENDPOINT}/${id}?teamId=${VERCEL_ORG_ID}"
    curl -s -X DELETE "$delete_url" -H "Authorization: Bearer $VERCEL_TOKEN"
done



