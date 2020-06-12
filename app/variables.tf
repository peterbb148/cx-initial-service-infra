variable region {}            
variable account {} 
variable vpc_id {} 
variable public_subnets_ids {} 
variable private_subnets_ids {} 
variable environment {} 
variable memory {}
variable cpu {}
# APP
variable app_name {} 
variable image_ecr {}
variable image_tag {}
variable container_port_app {}
variable container_volumes {
    default = []
}
variable lb_security_groups {
    default = [] 
}
variable registry {} 
variable enable_https {}
variable http_action {}
variable lb_s3_is_enabled {}
variable cluster_name {}
variable container_name {}  
variable num_servers {}

# Route53
# variable type {}
# variable zone_id {}
# variable TTL {}