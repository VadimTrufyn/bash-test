#!/bin/bash


# Get the Vercel API endpoints.
GET_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v6/deployments"
DELETE_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v13/deployments"

ACTIONS=$1

# Create a list of deployments.
uid==$(curl -s -X GET "$GET_DEPLOYMENTS_ENDPOINT/?projectId=$VERCEL_PROJECT_ID&teamId=$VERCEL_ORG_ID&limit=1000" -H "Authorization: Bearer $VERCEL_TOKEN " | jq -r --arg branch "$BRANCH" '.deployments[] | select(.meta.githubCommitRef == $branch) | .uid')

echo "Filtered deployments ${uid}"
echo "action $ACTIONS to destroy"
echo "================================================================="


for id in $uid; do
    echo "================================================================="
    echo "Deleting deployment $id ..."        
    delete_url="${DELETE_DEPLOYMENTS_ENDPOINT}/${id}?teamId=${VERCEL_ORG_ID}"
    response=$(curl -s -X DELETE "$delete_url" -H "Authorization: Bearer $VERCEL_TOKEN")


done

