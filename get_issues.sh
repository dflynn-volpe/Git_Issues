#!/bin/bash

file="git_repo_token.txt" #the file containing just a string with the personal access token (PAT)

token=$(cat "$file")        #the output of 'cat $file' is assigned to the $token variable

echo $token

# View all issue assigned to the user with this PAT
#curl -i -H "Authorization: token $token" \
#    https://api.github.com/issues

# View all issues in a private repo and save output to a json file
# do not -i include HTTP-header

curl \
  -H "Authorization: token $token" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/VolpeUSDOT/RDR/issues?state=all&per_page=100" \
  -o "RDR_issues.json"

curl \
  -H "Authorization: token $token" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/VolpeUSDOT/RDR/issues?state=all&page=2&per_page=100" \
  -o "RDR_issues2.json"
