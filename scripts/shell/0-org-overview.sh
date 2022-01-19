#!/bin/bash
# get started -> bash scripts/shell/0-org-overview.sh
ORG_ALIAS=DevHub
RECORD_COUNT_SOBJECTS=Account,Contact,Lead,Opportunity # comma-separated list of API names
LICENSE_QUERY="SELECT Name, TotalLicenses, UsedLicenses 
FROM UserLicense 
WHERE Status = 'Active' AND (Name LIKE '%Salesforce%' OR Name LIKE '%Community%')
ORDER By Name DESC"

# define devideLine method
devideLine() {
    echo ""
    echo "========== DEVIDE LINE =========="
    echo ""
}

echo "check org limits in ${ORG_ALIAS} org"
sfdx force:limits:api:display -u ${ORG_ALIAS}

# call devide line
devideLine

echo "check license usage in ${ORG_ALIAS} org"
sfdx force:data:soql:query -q "$(echo $LICENSE_QUERY)" -u ${ORG_ALIAS}

# call devide line
devideLine

echo "check data usage in ${ORG_ALIAS} org"
sfdx force:limits:recordcounts:display -s ${RECORD_COUNT_SOBJECTS} -u ${ORG_ALIAS}
