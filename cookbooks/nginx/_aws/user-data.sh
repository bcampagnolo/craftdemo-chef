#!/bin/bash
set -x
# ARTIFACT_NAME="chef-12.22.1-1.el7.x86_64.rpm"
# S3_ARTIFACT_BUCKET_NAME="s3://496911069803-us-west-2-artifacts/rpm"
# DEST_DIR="/tmp/deploy"

# # Create DEST_DIR
# mkdir -p "${DEST_DIR}" && cd "${DEST_DIR}" || exit 'Cannot cd to ${DEST_DIR}'

# # Download the artifact
# #aws s3 cp "${S3_ARTIFACT_BUCKET_NAME}/${ARTIFACT_NAME}" ${DEST_DIR}

# # Rename artifact
# #mv ${ARTIFACT_NAME} shell-services.zip
# #rpm -ivh ${DEST_DIR}/${ARTIFACT_NAME}

# touch "${DEST_DIR}"/user_data.txt

# Temporarily override the default umask of 0077
umask 0022

# Set the default region for the AWS CLI/SDK
echo export AWS_DEFAULT_REGION=us-west-2 > /etc/profile.d/aws_default_region.sh && . /etc/profile.d/aws_default_region.sh

mkdir -p /tmp/deploy
cd /tmp/deploy

###### Download chef out of s3 ######s
# 496911069803-us-west-2-artifacts/chef/cookbooks.zip
aws s3 cp s3://496911069803-us-west-2-artifacts/chef/cookbooks.zip craft-web-server.zip

if [ $? -ne 0 ]; then
    # Unrecoverable error, so fail fast
    cfn-signal --region us-west-2 --resource AutoScalingGroup --stack craft-web-server --success false
fi

unzip -o craft-web-server.zip -d cookbooks

# ###### Run Chef ######
mkdir -p /var/log/chef

cd cookbooks
ls config/solo.rb
ls nodes/web-services/us-west-2/dev.json

chef-solo -c config/solo.rb -j nodes/web-services/us-west-2/dev.json -l debug --force-logger

if [ $? -eq 0 ]; then
    # All done!
    cfn-signal --region us-west-2 --resource AutoScalingGroup --stack ${AWS::StackName}
else
    # Deploy failed upload logs and die
    INSTANCE_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
    curl -s http://169.254.169.254/latest/user-data > /var/log/user-data.log
    # flask-west2-prod-west2-logs/fail_deploys/
    for log in /var/log/chef/chef.log /var/log/userdata.log /var/log/boot.log /var/log/cloud-*.log /var/log/nginx/access.log /var/log/nginx/error.log; do
        [ -f $log ] && aws s3 cp --acl bucket-owner-full-control $log s3://flask-west2-prod-west2-logs/fail_deploys/craft-web-server/$INSTANCE_ID/`basename $log`
    done
    #shutdown -h now
fi