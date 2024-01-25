variable "vpc_cidr" {
  description = "vpc ip or cidr range"
  type        = string
}

#vpc subnets 
variable "vpc_subnets_cidr" {
  description = "creating two subnets with a count function"
  type        = list(string)
}

