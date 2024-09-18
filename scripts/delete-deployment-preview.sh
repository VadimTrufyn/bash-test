#!/bin/bash


VERCEL_PROJECT_ID=prj_GF2SVVkgkr9fTe2UAbwMn3nPogMh
VERCEL_ORG_ID=team_jjtPNd6UnSqoqdfHQr2oNAnG
VERCEL_TOKEN=NlGa3rGGAbnRunGJIqNR6sVp
# Get the Vercel API endpoints.
GET_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v6/deployments"
DELETE_DEPLOYMENTS_ENDPOINT="https://api.vercel.com/v13/deployments"

ACTIONS=apply

# Create a list of deployments.
deployments=$(curl -s -X GET "$GET_DEPLOYMENTS_ENDPOINT/?projectId=$VERCEL_PROJECT_ID&teamId=$VERCEL_ORG_ID&limit=1000" -H "Authorization: Bearer $VERCEL_TOKEN ")

filtered_deployments=$(echo $deployments | jq -r --arg branch "$BRANCH" '.deployments[] | select(.meta.githubCommitRef == $branch) | .uid' )
uid="${filtered_deployments//\"/}" # Remove double quotes
echo "Filtered deployments ${uid}"
echo "action $ACTIONS to destroy"
echo "================================================================="

if [ $ACTIONS == "plan" ]; then       
    echo $deployments | jq -r --arg branch "$BRANCH" '.deployments[] | select(.meta.githubCommitRef == $branch)'
    for id in $uid; do
        echo "Plan to delete deployment "
        echo $id
        echo "================================================================="       
    done
elif [ $ACTIONS == "apply" ]; then
    for id in $uid; do
        echo "================================================================="
        echo "Deleting deployment $id ..."        
        delete_url="${DELETE_DEPLOYMENTS_ENDPOINT}/${id}?teamId=${VERCEL_ORG_ID}"
        response=$(curl -s -X DELETE "$delete_url" -H "Authorization: Bearer $VERCEL_TOKEN")

    done
else
    echo "Invalid action specified. Please use 'plan' or 'apply'."
    echo "Usage: $0 <branch> <action>"
    
fi
