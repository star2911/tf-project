

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnet1" {
  type = string
}
variable "public_subnet2" {
  type = string
}

variable "security_groups" {
  type = string
}
variable "project-asg" {
  type = string
  
}