#!/bin/bash
set -e

echo -e "\e[33mExporting credentials...\e[0m"
source openstack-credentials.sh
echo -e "\e[92mSUCCESS: Exported credentials\e[0m"

cd terraform
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -auto-approve

echo -e "\n\e[33mWaiting for VMs to come up...\e[0m"
sleep 120
echo -e "\e[92mSUCCESS: All VMs are up and running\e[0m\n"

echo -e "\e[33mRUNNING: Ansible playbook\e[0m"
cd ../ansible
ansible-playbook deployment.yml
echo -e "\e[92mSUCCESS: Ansible configured the VMs\e[0m"

echo -e "\e[36mThank you for using the deployer you can now visit your OpenStack Dashboard to see the VMs\e[0m"
