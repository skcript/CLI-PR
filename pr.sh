#!/usr/bin/env bash
#
# CLI-PR is a simple bash script that helps you issue a Pull Request from CLI.
#
# Meet the dependencies:
#   Install Hub (https://github.com/github/hub)
#   > brew install hub
#   Check if Hub works:
#   > hub browse 
#
# Customize this script to work with your repo:
#   "origin" - <your forked URL>
#   "companyname" - skcript/<reponame>
#   "repo-name" - <name of your repository>
#   "branch" - <Your upstream branch name>
#
UPSTREAM=<companyname>/<repo-name>:<branch>

# Get the Pull Request Title from the user
echo -n "PR Title: "
read title

# Make sure everything is in sync and committed
topic_branch=`git rev-parse --abbrev-ref HEAD`
git push origin ${topic_branch}

# Tell Hub to issue a PR with the credentials and store the temporary PR URL to a file in /tmp folder
hub pull-request -b ${UPSTREAM} -F - > /tmp/last_pr_url <<MSG
${title}

# Check for a Pull Request template
`cat PULL_REQUEST_TEMPLATE`
MSG
pr_url=`cat /tmp/last_pr_url`
# Open the new PR URL in the default browser.
echo "Opening ${pr_url}"
open ${pr_url}
# DO GREAT WORK!
