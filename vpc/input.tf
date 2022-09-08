variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type = string
  description = "this is the vpc cidr"
}


variable "subnets_cidr" {
  default = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
  description = "this is the vpc cidr"
}


variable "subnets_azs" {
  default     = ["us-west-2a","us-west-2b","us-west-2a","us-west-2b"]
  description = "there are subnet availability zones"
  
}

variable "subnet_tags" {
  default     = ["web-1","web-2","db-1","db-2"]
  description = "these are subnet tags"
  
}






