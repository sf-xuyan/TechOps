#!/bin/bash
# get started -> bash scripts/shell/3-jwt-login-to-sfdx.sh

# import method from external shell script
. scripts/shell/util.sh

# the 2nd param is optiona, if you pass it as prod_, then you can use ${prod_sfdc_loginUrl} to get the value of the key `sfdc_loginUrl`
loadProperties secretfile/twcompsa.properties

ORG_ALIAS=DevHub

echo "Setup: Login to SFDX"
{ # try
    sfdx auth:logout --noprompt --targetusername $sfdc_username
} || { # catch
    echo "No default username found"
}

sfdx auth:jwt:grant -i $sfdc_client_id -r $sfdc_loginUrl -u $sfdc_username -f "$sfdc_jwtkeyfile" -s -a $ORG_ALIAS