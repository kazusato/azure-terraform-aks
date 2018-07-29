#!/usr/bin/env bash

cluster_rg_name=aks_istio_rg
cluster_name=aks_istio_cluster
cluster_location=japaneast

infra_rg=MC_${cluster_rg_name}_${cluster_name}_${cluster_location}
echo ${infra_rg}

vmlist=$(az vm list -g ${infra_rg} --query "[].{name: name}" -o tsv)
echo ${vmlist}
for i in ${vmlist}
do
 echo "Starting VM ${i}"
 az vm start -g ${infra_rg} -n ${i} --no-wait
done
