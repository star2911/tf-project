module "vpc" {
  source = "./VPC"

}

module "ec2" {
    source = "./EC2"
    vpc_id = module.vpc.vpc_id
    public_subnet1 = module.vpc.public_subnet1
    role_profile = module.IAM.role_name
    
  
}

module "ASG" {
  source = "./ASG"
  key_name = module.ec2.key_name
  private_subnet1 = module.vpc.private_subnet1
  security_groups = [module.ec2.security_groups]
  user_data = filebase64("web-script.sh")

}
module "ALB" {
  source = "./ALB"
  vpc_id = module.vpc.vpc_id
  project-asg = module.ASG.autoscaling_group_name
  security_groups = module.ec2.security_groups
  public_subnet1 = module.vpc.public_subnet1
  public_subnet2 = module.vpc.public_subnet2
  
}
module "IAM" {
  source = "./IAM"
}

module "S3" {
  source = "./S3"
}
module "rds" {
  source = "./RDS-DB"
  private_subnet1 = module.vpc.private_subnet1
  private_subnet2 = module.vpc.private_subnet2
  security_groups = module.ec2.security_groups
}

# module "bastion_host" {
#   source          = "./modules/bastion_host"
#   key_name        = "bastion-key"
#   public_key_path = "/path/to/public/key.pub"
#   ami_id          = "ami-xxxxxxxxxxxxxxxxx"  # Provide a valid AMI ID
#   instance_type   = "t2.micro"
#   subnet_id       = "subnet-xxxxxxxxxxxxxxxxx"  # Provide a valid subnet ID
#   instance_name   = "bastion-host"
# }

# module "vpc" {
#   source            = "./modules/vpc"
#   vpc_name          = "my-vpc"
#   vpc_cidr_block    = "10.0.0.0/24"
#   public_subnet_cidr = "10.0.0.0/25"
#   public_subnet_az  = "us-west-2a"
# }

# module "iam_role" {
#   source    = "./modules/iam_role"
#   role_name = "ec2-admin-role"
# }

# module "rds" {
#   source                  = "./modules/rds"
#   subnet_group_name       = "my-db-subnet-group"
#   subnet_ids              = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]  # Provide a list of valid subnet IDs
#   db_instance_identifier  = "my-db-instance"
#   allocated_storage       = 20
#   storage_type            = "gp2"
#   engine                  = "mysql"
#   engine_version          = "5.7"
#   instance_class          = "db.t2.micro"
#   username                = "admin"
#   password                = "password123"
#   # Optionally, adjust other variables as needed

  
# }


# module "s3_bucket" {
#   source                = "./modules/s3_bucket"
#   primary_bucket_name   = "primary-bucket-name"
#   replica_bucket_name   = "replica-bucket-name"
#   replication_role_arn  = "arn:aws:iam::123456789012:role/replication-role"
# }

# module "elb" {
#   source             = "./elb"
#   environment        = "prod"
#   vpc_id             = module.vpc.vpc_id
# public_subnet =  module.vpc.public_subnet_id
# public_subnet2 = module.vpc.public_subnet2

#   security_groups = module.security.web_sg_id

#   common_tags        = { "Project" = "MyProject", "Environment" = "prod" }
# }

# module "autoscaling" {
#   source = "./autoscaling"
#   min_size             = 1
#   max_size             = 3
#   desired_capacity     = 2
#   key_name = module.bastion.key_name
#   # vpc_zone_identifier  = module.vpc.private_subnets_ids
#   private_subnet = module.vpc.private_subnet_id
#   security_groups      = [module.security.web_sg_id]
#   target_group_arn     = module.elb.target_group_arn
#   common_tags          = {
#     Project     = "MyProject"
#     Environment = "prod"
#   }
#   environment = "prod"
# }