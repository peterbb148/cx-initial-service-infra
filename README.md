# cx-initial-service-infra

The purpose of this repo is to create and deploy a service named "cx-initial-service" to the Dev-DigitalCluster.

We want this to happen:

* Name of service is cx-el-macho-grande-service
* ECS CLuster is Dev-DigitalCluster
* Starting image is regular initial-image from 483459036065.dkr.ecr.eu-west-1.amazonaws.com/initial-image:latest

Then you have to do this:

* Change this file and these variables...

./app/main.tf:

    key = "infra/aws/carlsberg-dev-4834-5903-6065/acn-gbs-cxproject-dev-01/dev/THE_NAME_OF_YOUR_SERVICE/app/state.tf"

Replace "THE_NAME_OF_YOUR_SERVICE" with the name of your service. In this case with cx-el-macho-grande-service

variables.tfvars:

# APP     
app_name                 = "cx-el-macho-grande-service"

#ECS
cluster_name             = "Dev-DigitalCluster"
container_name           = "cx-el-macho-grande-service"
container_port_app       = 8080
num_servers              = 1


