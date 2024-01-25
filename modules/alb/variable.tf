variable "sg_id" {
  description = "security group id for application load balancer"
  type = string
}

variable "subnets" {
  description = "Subnet for ALB"
  type = list(string)
}

variable "vpc_id" {
  description = "vpc id for ALB"
  type = string
}

variable "instances" {
  description = "Instance ID for target group attachment"
  type = list(string)
}