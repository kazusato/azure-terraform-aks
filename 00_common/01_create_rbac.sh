#!/usr/bin/env bash

TARGET_LOCATION=japaneast
TF_STATE_RG_NAME=tf_state_rg
TF_PROJ_NAME=aks
RBAC_ACCOUNT_NAME=tf-contributor-${TF_PROJ_NAME}

export TF_STATE_CONTAINER_NAME=tf-state-${TF_PROJ_NAME}
export TF_STATE_KEY=dev.terraform.tfstate

ACCOUNT_JSON=$(az account show --query "{subscriptionId:id, tenantId:tenantId}")
echo ${ACCOUNT_JSON}

export SUB_ID=$(echo ${ACCOUNT_JSON} | jq .subscriptionId -r)
export TENANT_ID=$(echo ${ACCOUNT_JSON} | jq .tenantId -r)

RBAC_JSON=$(az ad sp create-for-rbac -n ${RBAC_ACCOUNT_NAME} --role="Contributor" --scopes="/subscriptions/${SUB_ID}")
echo ${RBAC_JSON}

export APP_ID=$(echo ${RBAC_JSON} | jq .appId -r)
export SP_NAME=$(echo ${RBAC_JSON} | jq .name -r)
export PASSWORD=$(echo ${RBAC_JSON} | jq .password -r)

# Storage account for remote state backend

export TF_STATE_ACCOUNT=$(az storage account list -g ${TF_STATE_RG_NAME} --query '[].name' -o tsv)
echo ${TF_STATE_ACCOUNT}

export TF_STATE_ACCESS_KEY=$(az storage account keys list -n ${TF_STATE_ACCOUNT} -g ${TF_STATE_RG_NAME} --query '[?keyName==`key1`].{value:value}' -o tsv)

az storage container create -n ${TF_STATE_CONTAINER_NAME} --account-name ${TF_STATE_ACCOUNT} --account-key ${TF_STATE_ACCESS_KEY}

cat ZZ_azure_config.sh.template | envsubst | tee nogit/ZZ_azure_config.sh
cat ZZ_remote_state.sh.template | envsubst | tee nogit/ZZ_remote_state.sh
