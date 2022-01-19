#!/bin/bash
# get started -> bash scripts/shell/1-bulk-delete-records.sh
# note -> don't forget to check the batch status by the cmd returned in terminal console
# i.e. sfdx force:data:bulk:status -i 7505j000000dKuwAAE -b 7515j000000dJPcAAM
ORG_ALIAS=DevHub
SOBJECT=ApexLog
SOQL="SELECT Id FROM ${SOBJECT}"
# SOBJECT=Account
# SOQL="SELECT Id FROM ${SOBJECT} where Id = '0015j000004oWC7AAM'"
FILE_NAME=data/temp/${SOBJECT}.csv
DESCRIPTION="bulk delete ${SOBJECT} records"

echo $DESCRIPTION

# -t | --usetoolingapi: execute query with Tooling API
sfdx force:data:soql:query -q "${SOQL}" -r "csv" > ${FILE_NAME} -u ${ORG_ALIAS}

# The file must be a CSV file with only one column: "Id".
sfdx force:data:bulk:delete -s ${SOBJECT} -f ${FILE_NAME} -u ${ORG_ALIAS}