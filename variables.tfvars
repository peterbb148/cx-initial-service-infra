# Global
region                   = "eu-west-1"
environment              = "dev"
account                  = "483459036065"

#Network Info
#VPC
vpc_id                   = "vpc-05e63afcec4367619"
# Subnets
public_subnets_ids       = ["subnet-0b974acde8839b815","subnet-0b3c1d39656c832d9","subnet-0a653cdb99c033f3f"]
private_subnets_ids      = ["subnet-0f183aa846de70e5c","subnet-0c5186e6aef47899b","subnet-01e882eedcb4bed25"]
     
    
# APP     
app_name                 = "ct-geoip-service-be" 

#ECS
cluster_name             = "dev-layer2-backend-01"
container_name           = "ct-geoip-service-be"
container_port_app       = 8080
num_servers              = 1

# Task definition 
registry                 = "483459036065.dkr.ecr.eu-west-1.amazonaws.com/"
image_ecr                = "initial-image"
image_tag                = "latest"

#Load Balancer
enable_https             = true
http_action              = "redirect"
lb_s3_is_enabled         = false

# CPU and memory
memory                   = "256"
cpu                      = "0"

# Parameters store
SPRING_PROFILES_ACTIVE   = "ecs-dev"
SERVER_PORT              = "8080"


# Route 53
type                    = "CNAME"
zone_id                 = "Z0900910YMJ3B4YNL2YY"
TTL                     = "600"


