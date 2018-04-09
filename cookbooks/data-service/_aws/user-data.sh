#!/bin/bash

ARTIFACT_NAME="chef-12.22.1-1.el7.x86_64.rpm"
S3_ARTIFACT_BUCKET_NAME="s3://496911069803-us-west-2-artifacts/rpm"
DEST_DIR="/tmp/deploy"

# Create DEST_DIR
mkdir -p "${DEST_DIR}" && cd "${DEST_DIR}" || exit 'Cannot cd to ${DEST_DIR}'

# Download the artifact
aws s3 cp "${S3_ARTIFACT_BUCKET_NAME}/${ARTIFACT_NAME}" ${DEST_DIR}

# Rename artifact
#mv ${ARTIFACT_NAME} shell-services.zip
rpm -ivh ${DEST_DIR}/${ARTIFACT_NAME}
