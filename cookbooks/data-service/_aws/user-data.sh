#!/bin/bash

ARTIFACT_NAME="indescision-1.0.zip"
S3_ARTIFACT_BUCKET_NAME="s3://496911069803-us-west-2-artifacts/data-service/craftdemo-data/dist"
DEST_DIR="/tmp/deploy"

# Create DEST_DIR
mkdir -p "${DEST_DIR}" && cd "${DEST_DIR}" || exit 'Cannot cd to ${DEST_DIR}'

# Download the artifacts
aws s3 cp "${S3_ARTIFACT_BUCKET_NAME}/${ARTIFACT_NAME}" ${DEST_DIR}

# Rename artifact
mv ${ARTIFACT_NAME} flask.zip

