#!/usr/bin/env bash

COMPANY_NAME=${1:-companyname}

brew help &>/dev/null || {
    echo "Install brew, I'm not doing that for you:"
    # shellcheck disable=SC2016
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
}

brew install go-jira
brew install fzf
brew install pipx
pipx install python-slugify

echo "Setup go-jira"

JIRA_CFG_DIR="$HOME/.jira.d/"
JIRA_CFG_FILE="$JIRA_CFG_DIR/config.yml"
JIRA_CFG_TEMPLATES_DIR="$JIRA_CFG_DIR/templates"

if [[ -f $JIRA_CFG_FILE ]]; then
    echo "Some config is present in $JIRA_CFG_FILE"
    echo "I'm not smart enough to merge YAML files."
    echo "Follow instructions from the README to configure go-jira"
    exit
fi

echo "Creating Jira CLI config"

mkdir -p "$JIRA_CFG_TEMPLATES_DIR"
echo cp -v -n ./config/jira.d/templates/* "$JIRA_CFG_TEMPLATES_DIR/"
cp -v -n ./config/jira.d/templates/* "$JIRA_CFG_TEMPLATES_DIR/"

read -r -p "What is the endpoint? " -e -i "https://$COMPANY_NAME.atlassian.net" endpoint
read -r -p "What is the email? " -e -i "$USER@$COMPANY_NAME.com" email
echo -e "endpoint: $endpoint\nuser: $email" >"$JIRA_CFG_FILE"

cat ./config/jira.d/config.yml >>"$JIRA_CFG_FILE"

[[ -n $endpoint ]] && {
    echo "We will run 'jira session' to fishing setting up"
    echo "⚠️ It will ask for a Jira API token: https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/"
    jira session
}
