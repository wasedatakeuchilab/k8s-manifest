#! /usr/bin/env bash

set -uC
set -o pipefail

addons=(
    "dns:192.168.0.100"
    "dashboard"
    "ingress"
    "metallb:192.168.0.100-192.168.0.110"
    "community"
    # Community addons
    "nfs"
)

# Install addons
for addon in "${addons[@]}"; do
    microk8s enable "$addon"
    sleep 10
done

# Install dashboard-ingress
microk8s enable dashboard-ingress --hostname dashboard.k8s.lab

# Set nfs storage class as default
kubectl patch storageclass nfs -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
