#!/bin/bash
. ./.env
echo $SF_USERNAME

sfdx force:source:convert -d src
sfdx force:mdapi:deploy -u $SF_USERNAME -d src -w 1