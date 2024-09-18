#!/bin/bash

# Get the Vercel API endpoints.
GET_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v6/deployments"
DELETE_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v13/deployments"

ACTIONS=apply

# Create a list of deployments.

filtered_deployments=$(curl -s -X GET "$GET_DEPLOYMENTS_ENDPOINT/?projectId=$VERCEL_PROJECT_ID&teamId=$VERCEL_ORG_ID&limit=1000" -H "Authorization: Bearer $VERCEL_TOKEN "| jq -r --arg branch "$BRANCH" '.deployments[] | select(.meta.githubCommitRef == $branch) | .uid' )
uid="${filtered_deployments//\"/}" # Remove double quotes
echo "Filtered deployments ${uid}"

echo "================================================================="

if [ $ACTIONS == "plan" && $uid != "" ]; then       
    echo $(curl -s -X GET "$GET_DEPLOYMENTS_ENDPOINT/?projectId=$VERCEL_PROJECT_ID&teamId=$VERCEL_ORG_ID&limit=1000" -H "Authorization: Bearer $VERCEL_TOKEN " | jq -r --arg branch "$BRANCH" '.deployments[] | select(.meta.githubCommitRef == $branch)') || echo "preview doesnt exist for branch $BRANCH"
    for id in $uid; do
        echo "Plan to delete deployment "
        echo $id || echo "preview doesnt exist for branch $BRANCH"
        echo "================================================================="       
    done
elif [ $ACTIONS == "apply" ]; then
    for id in $uid; do
        echo "action $ACTIONS to destroy"
        echo "================================================================="
        echo "Deleting deployment $id ..."        
        delete_url="${DELETE_DEPLOYMENTS_ENDPOINT}/${id}?teamId=${VERCEL_ORG_ID}"
        response=$(curl -s -X DELETE "$delete_url" -H "Authorization: Bearer $VERCEL_TOKEN")

    done
else
    echo "Invalid action specified. Please use 'plan' or 'apply'."
    echo "Usage: $0 <branch> <action>"
    
fi
