resource "aws_db_subnet_group" "star_subnet_group" {
  name       = "star-subnet-group"
  subnet_ids = ["${var.private_subnet1}","${var.private_subnet2}"]
}
resource "aws_db_instance" "star_db_instance" {
  identifier           = "star-db-instance"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"

  username             = "admin"
  password             = "password"
  db_subnet_group_name = aws_db_subnet_group.star_subnet_group.name
  vpc_security_group_ids = [var.security_groups] # Replace with your security group ID
  skip_final_snapshot     = true
  final_snapshot_identifier = "final-snapshot-name"
}