variable "vpc_cidr" {
  description = "creating a cidr"
  type = string
}

variable "vpc_subnets_cidr" {
  description = "creating two subnets with a count function"
  type = list(string)
}

variable "subnet_names" {
  description = "creating two public subnets name"
  type = list(string)
  default = ["public_subnet_1", "public_subnet_2"]
}