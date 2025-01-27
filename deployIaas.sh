#! /bin/bash
if [[ $1 == "start" ]]; then
echo "Starting the deployment of the IaaS..."
cd terraformvm
terraform plan -out main.tfplan
terraform apply main.tfplan
echo "don't forget to put the public IP, the ssh user and the ssh private key (in terraformvm/ssh_private_key.pem) in the github secrets HOST, USERNAME, SSHPRIVATEKEY"

elif [[ $1 == "stop" ]]; then
echo "Stopping the deployment of the IaaS..."
cd terraformvm
terraform plan -destroy -out main.destroy.tfplan
terraform apply main.destroy.tfplan


else
echo "Usage: $0 [start|stop]"

fi
