#!/bin/bash

# Script to update the image tag for the specified container in a deployment.yaml

# Check if the new image tag is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <new-image-tag>"
  exit 1
fi

# Assign the new image tag from script arguments
NEW_IMAGE_TAG="$1"
DEPLOYMENT_FILE="deployment.yaml"  # Path to the Kubernetes deployment file

# Check if the deployment file exists
if [ ! -f "$DEPLOYMENT_FILE" ]; then
  echo "Error: Deployment file does not exist at $DEPLOYMENT_FILE"
  exit 1
fi

# Define the container name
CONTAINER_NAME="java-application"

# Using sed to replace the image tag in the deployment file
# This command targets the 'image' field following the specified container name
# It will retain the existing image name but update the tag after the colon
sed -i "/name: $CONTAINER_NAME/,/image:/s|image: \([^:]*\):.*|image: \1:$NEW_IMAGE_TAG|" "$DEPLOYMENT_FILE"

echo "Deployment file $DEPLOYMENT_FILE updated with new image tag $NEW_IMAGE_TAG for container $CONTAINER_NAME."

