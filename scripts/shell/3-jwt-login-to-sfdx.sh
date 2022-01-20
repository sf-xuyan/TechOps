#!/bin/bash
# get started -> bash scripts/shell/3-jwt-login-to-sfdx.sh
ORG_ALIAS=DevHub
INSTANCE_URL=https://login.salesforce.com
USERNAME=wilson@tw.com.psa
CONSUMER_KEY=3MVG9pRzvMkjMb6m_3dxb047MysYFe0238m3imdwdl.iXMrABXSmvtuM0PQQ8qpydkICmSit6mpFDLKEFMxu3
KEY_FILE=JWT/server.key

echo "Setup: Login to SFDX"
{ # try
    sfdx force:auth:logout --noprompt --targetusername $USERNAME
} || { # catch
    echo "No default username found"
}

sfdx force:auth:jwt:grant -i $CONSUMER_KEY -r $INSTANCE_URL -u $USERNAME -f "$KEY_FILE" -s -a $ORG_ALIAS