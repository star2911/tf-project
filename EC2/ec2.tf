# 4. Create Bastion host (EC2)
resource "aws_key_pair" "bh-key" {
  key_name   = "bh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "star_bh" {
  ami           = "ami-0866a04d72a1f5479"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.bh-key.key_name
  subnet_id     = var.public_subnet1
  availability_zone  = "us-east-2a"
  vpc_security_group_ids = [aws_security_group.star_sg.id]
  iam_instance_profile = var.role_profile
  tags = {
    Name = "star_bh"
  }
}
# 5. Create Private EC2 - t2.micro (Nginx should be installed) - Same key-pair
# resource "aws_instance" "private_instance" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.bh-key.key_name
#   subnet_id     = aws_subnet.private_subnet.id
#   availability_zone = "us-east-2b"
#   user_data = <<-EOF
#               #!/bin/bash
#               yum install -y nginx
#               systemctl start nginx
#               systemctl enable nginx
#               EOF
#   tags = {
#     Name = "priv-instance"
#   }
# }
# # 6. Create 1 role with EC2adminpolicy
# resource "aws_iam_role" "ec2_admin_role" {
#   name = "ec2-admin-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }
# resource "aws_iam_role_policy_attachment" "admin_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
#   role       = aws_iam_role.ec2_admin_role.name
# }