#!/bin/bash

# Create DEST_DIR
mkdir -p /tmp/deploy && cd /tmp/deploy || exit 'Cannot cd to ${DEST_DIR}'

# Download the artifacts
aws s3 cp "s3://496911069803-us-west-2-artifacts/data-service/craftdemo-data/dist/indecision-1.0.zip" /tmp/deploy

# Rename artifact
cd /tmp/deploy
ls indecision-1.0.zip

