resource "aws_launch_template" "project_launch_template" {
  description    = "Example Launch Template"
  image_id = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name

  

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id      = var.private_subnet1
    security_groups     = var.security_groups
  }
   

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ExampleInstance"
    }
  }
  user_data = var.user_data
}




resource "aws_autoscaling_group" "project-asg" {
  availability_zones = ["us-east-2a"]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2

  launch_template {
    id      = aws_launch_template.project_launch_template.id
    version = "$Latest"
  }
}







# resource "aws_launch_template" "example" {
#   name_prefix   = "example"
#   image_id      = var.image_id
#   instance_type = var.instance_type

#   monitoring {
#     enabled = true
#   }

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "example-instance"
#     }
#   }
# }

# resource "aws_autoscaling_group" "example" {
#   name                     = var.asg_name
#   vpc_zone_identifier      = var.subnet_ids
#   max_size                 = var.max_size
#   min_size                 = var.min_size
#   desired_capacity         = var.desired_capacity
#   launch_template {
#     id      = aws_launch_template.example.id
#     version = "$Latest"
#   metric_trigger {
#     metric_name = "CPUUtilization"
#     namespace   = "AWS/EC2"
#     statistic   = "Average"
#     unit        = "Percent"
#     threshold   = 60
#     period      = 300
#     evaluation_periods  = 2
#     cooldown            = 300
#     comparison_operator = "GreaterThanOrEqualToThreshold"
#   }
# }