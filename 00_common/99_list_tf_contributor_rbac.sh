#!/usr/bin/env bash
az ad sp list --query '[].{displayName:displayName, appId:appId}' -o table | grep tf-contributor
