#!/bin/bash
# get started -> bash scripts/shell/0-org-overview.sh

. scripts/shell/util.sh

ORG_ALIAS=DevHub
RECORD_COUNT_SOBJECTS=Account,Contact,Lead,Opportunity # comma-separated list of API names
LICENSE_QUERY="SELECT Name, TotalLicenses, UsedLicenses 
FROM UserLicense 
WHERE Status = 'Active' AND (Name LIKE '%Salesforce%' OR Name LIKE '%Community%')
ORDER By Name DESC"
SCRATCH_ORG_QUERY="SELECT Id, OrgName, Namespace, Edition, SignupTrialDays, ExpirationDate, SignupUsername, CreatedDate, Description
FROM ActiveScratchOrg
"

echo "check active scrach org"
sfdx force:data:soql:query -q "${SCRATCH_ORG_QUERY}" -u ${ORG_ALIAS}
# sfdx force:data:record:delete -s ActiveScratchOrg -i $Id

# call devide line
devideLine

echo "check org limits in ${ORG_ALIAS} org"
sfdx force:limits:api:display -u ${ORG_ALIAS}

devideLine

echo "check license usage in ${ORG_ALIAS} org"
sfdx force:data:soql:query -q "$(echo $LICENSE_QUERY)" -u ${ORG_ALIAS}

# call devide line
devideLine

echo "check data usage in ${ORG_ALIAS} org"
sfdx force:limits:recordcounts:display -s ${RECORD_COUNT_SOBJECTS} -u ${ORG_ALIAS}
