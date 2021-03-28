#!bin/bash
# Run infra.sh first.
# We need to check like, az account set --subscription <>, az aks get-credentials  --resource-group <> --name <>
# If we need to add both in single sciprt then need to add output.tf

git clone https://github.com/flipgrid/fg-devops-saitheja.git
unzip fg-devops-saitheja-master.zip

cd ~/fg-devops-saitheja-master/api
docker build -t fgtestsai.azurecr.io/api:latest .
cd ~/fg-devops-saitheja-master/web
docker build -t fgtestsai.azurecr.io/web:latest .
docker image push fgtestsai.azurecr.io/api:latest
docker image push fgtestsai.azurecr.io/web:latest

cd ~/fg-devops-saitheja-master/deploy
terraform init
terraform workspace list | grep prod
if [[ $? -ne 0 ]]; then
	terraform workspace new prod
fi	

#we need to load the config and azure authentication.
terraform workspace select prod
terrafrom plan -input=false -var="name_prefix=fgtestsai" -out=deployplan
terraform apply deployplan 


