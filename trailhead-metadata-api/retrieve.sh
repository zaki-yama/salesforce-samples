#!/bin/bash
. ./.env
echo $SF_USERNAME

sfdx force:source:convert -d src
sfdx force:mdapi:retrieve -u $SF_USERNAME -r src -w 1