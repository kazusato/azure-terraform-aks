#!/usr/bin/env bash

RBAC_JSON=$(az ad sp create-for-rbac -n aks-istio-rbac --skip-assignment)
echo ${RBAC_JSON}

export AKS_SP_CLIENT_ID=$(echo ${RBAC_JSON} | jq .appId -r)
export AKS_SP_PASSWORD=$(echo ${RBAC_JSON} | jq .password -r)

cat ZZ_aks_sp.sh.template | envsubst | tee nogit/ZZ_aks_sp.sh
