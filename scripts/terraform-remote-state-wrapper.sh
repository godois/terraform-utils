#!/bin/bash
set -e

PROJECT_PATH=$1
BUCKET=$2
KEY=$3
REGION=$4
COMMAND=$5
TERRAFORM=$(which terraform)

function main () {
	if [[ $1 = "-h" || $1 = "--help" ]]; then
		help
		exit 0
	fi

	if [[ -z $PROJECT_PATH || -z $BUCKET || -z $KEY || -z $REGION || -z $COMMAND ]]; then
		help
		exit 1
	else
		apply
	fi
	exit 0
}

function help () {
	echo -e "\n-----------------------------------------"
	echo -e "1st parameter: terraform root module path"
	echo -e "2nd parameter: s3 bucket holding tfstate files"
	echo -e "3rd parameter: path to s3 tfstate file"
	echo -e "4th parameter: default AWS region"
	echo -e "5th parameter: terraform command"
	echo -e "-----------------------------------------"
}

function apply () {
	cd $PROJECT_PATH
	$TERRAFORM get
	$TERRAFORM remote config -backend=s3 -backend-config="bucket=$BUCKET" -backend-config="key=$KEY" -backend-config="region=$REGION"
	$TERRAFORM plan
	$TERRAFORM $COMMAND
}

main \
	"$PROJECT_PATH" \
	"$BUCKET" \
	"$KEY" \
	"$REGION"