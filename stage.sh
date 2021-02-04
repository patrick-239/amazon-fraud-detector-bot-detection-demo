#!/bin/bash

# Staging script for copying deployment resources to an S3 bucket. 

set -e

BUCKET=$1
#Path with trailing /
S3PATH=$2

# remove this line if you want to keep the objects private in your S3 bucket
#export S3PUBLIC=" --acl public-read"

if [ ! -d "local" ]; then
    mkdir local
fi
touch local/stage.log

if [ "$BUCKET" == "" ]; then
    echo "Usage: $0 BUCKET [S3PATH]"
    echo "  where BUCKET is the S3 bucket to upload resources to and S3PATH is optional path but if specified must have a trailing '/'"
    exit 1
fi

BUCKET_LOCATION="$(aws s3api get-bucket-location --bucket ${BUCKET}|grep ":"|cut -d\" -f4)"
if [ -z "$BUCKET_LOCATION" ]; then
    BUCKET_DOMAIN="s3.amazonaws.com"
else
    BUCKET_DOMAIN="s3-${BUCKET_LOCATION}.amazonaws.com"
fi

# Remove Mac desktop storage files so they don't get packaged & uploaded
find . -name '.DS_Store' -type f -delete

echo " + Staging to $BUCKET in $S3PATH"

echo " + Uploading CloudFormation Templates"
aws s3 cp templates/ s3://${BUCKET}/${S3PATH}templates --recursive $S3PUBLIC
echo " For CloudFormation : https://${BUCKET_DOMAIN}/${BUCKET}/${S3PATH}templates/template.yaml"

echo " + Done s3://${BUCKET}/${S3PATH} "
echo " For CloudFormation : https://${BUCKET_DOMAIN}/${BUCKET}/${S3PATH}templates/template.yaml"
