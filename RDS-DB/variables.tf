variable "private_subnet1" {
  type = string
  
}
variable "private_subnet2" {
  type = string
  
}

variable "security_groups" {
   type = string  
}





# variable "subnet_group_name" {
#   description = "Name for the DB subnet group"
# }

# variable "subnet_ids" {
#   description = "List of subnet IDs where the DB will be deployed"
#   type        = list(string)
# }

# variable "db_instance_identifier" {
#   description = "Identifier for the DB instance"
# }

# variable "allocated_storage" {
#   description = "The allocated storage in gigabytes"
# }

# variable "storage_type" {
#   description = "The type of storage"
# }

# variable "engine" {
#   description = "The name of the database engine to be used"
# }

# variable "engine_version" {
#   description = "The engine version to use"
# }

# variable "instance_class" {
#   description = "The instance class to use"
# }

# variable "username" {
#   description = "The master username for the DB instance"
# }

# variable "password" {
#   description = "The master password for the DB instance"
# }

# variable "skip_final_snapshot" {
#   description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
#   default     = true
# }

# variable "publicly_accessible" {
#   description = "Determines if the DB instance is publicly accessible"
#   default     = false
# }