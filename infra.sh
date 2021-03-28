#!bin/bash

git clone https://github.com/flipgrid/fg-devops-saitheja.git
unzip fg-devops-saitheja-master.zip
cd ~/fg-devops-saitheja-master/infra
terraform init
terraform workspace list | grep prod
if [[ $? -ne 0 ]]; then
	terraform workspace new prod
fi	
terraform workspace select prod
terrafrom plan -input=false -var="name_prefix=fgtestsai" -var="node_pool_vm_size=1" -out=infaplan
terraform apply infraplan
