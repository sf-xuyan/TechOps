#!/bin/bash
# get started -> bash scripts/shell/2-data-tree-export.sh
ORG_ALIAS=DevHub
CURRENT_YEAR=$(date +%Y)
FILE_PATH=data/tree/

QUERY="SELECT  Id, AccountId, CloseDate, Account.Industry
FROM Opportunity
WHERE StageName = 'Closed Won'
AND CALENDAR_YEAR(CloseDate) = $CURRENT_YEAR"

echo "Running command: sfdx force:data:tree:export. Pulling from ${ORG_ALIAS} 
org. Records and Plan output to : ${FILE_PATH}"

# LIMIT: export up to 2,000 records per cmd.
sfdx force:data:tree:export -q "$(echo $QUERY)" -d ${FILE_PATH} -p -u ${ORG_ALIAS}

# LIMIT: import up to 200 records per cmd.
# sfdx force:data:tree:import -p data/Plan1.json -u ${ORG_ALIAS}
# sfdx force:data:tree:import -p data/Plan2.json -u ${ORG_ALIAS}